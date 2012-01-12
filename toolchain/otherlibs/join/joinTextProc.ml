let verbose =
  try
    int_of_string (Sys.getenv "TEXTVERBOSE")
  with _ -> 0


open Printf

let debug tag =
  if verbose > 0 then Join.debug tag
  else  ksprintf (fun _ -> ())


let pp_status = function
  | Unix.WEXITED i -> sprintf "EXIT %i" i
  | Unix.WSIGNALED i -> sprintf "SIGNAL %i" i
  | _ -> assert false

let safe_kill pid s =
  debug "TEXT" "KILL@%i" pid ;
  try Unix.kill pid s
  with Unix.Unix_error _ -> ()

let safe_close_out chan =
  try close_out chan
  with Sys_error _msg -> ()

let rec safe_wait pid =
  try
    let _,st = Unix.waitpid [] pid in
    debug "TEXT" "WAIT@%i: %s" pid (pp_status st);
    st
  with
  | Unix.Unix_error (Unix.EINTR,_,_) -> safe_wait pid



module Async = struct

  type producer = string JoinCom.P.t

  type t =
      { out : producer ;
        err : producer ;
        waitpid : Unix.process_status Join.chan Join.chan ;
        kill : int -> unit;
        gkill : int -> unit; }


  let et =
    let ep = JoinCom.P.empty() in
    { out=ep; err=ep;
      waitpid=(def k(_) = 0 in k);
      kill=(fun _ -> ());
      gkill=(fun _ -> ());
    }

      
  def producer_to_chan (prod,chan) = JoinCom.P.to_text_close (prod,chan)

  let async_kill pid prods chans =
    def kill(sid) =
      debug "TEXT" "KILL %i -> %i" sid pid ;
      List.iter (fun p -> spawn p.JoinCom.P.kill()) prods ;
      List.iter safe_close_out chans ;      
      safe_kill pid sid ;
      reply to kill in
    kill

  let add_kill_wait pid prods chans waited waitpid r =
    spawn waited(safe_wait pid) ;
    { r with
      kill=async_kill pid prods chans;
      gkill=async_kill (-pid) prods chans;
      waitpid=waitpid; }      

  let of_text chan = JoinCom.P.of_text chan

  let command cmd argv =
    let pid = JoinProc.command cmd argv in
    def waited(st) & waitpid(k) = waited(st) & k(st) in
    add_kill_wait pid [] [] waited waitpid et

  let open_in cmd argv =
    let pid,in_chan = JoinProc.open_in cmd argv in
    debug "TEXT" "START %i" pid ;
    def waited(st) & waitpid(k) = waited(st) & k(st) in
    let out = of_text in_chan in
    add_kill_wait pid [out] [] waited waitpid { et with out; }

  let open_out cmd argv input =
    let pid,out_chan = JoinProc.open_out cmd argv in
    debug "TEXT" "START %i" pid ;
    def waited(st) & waitpid(k) = waited(st) & k(st) in
    spawn producer_to_chan (input,out_chan) ;
    add_kill_wait pid [] [out_chan] waited waitpid et

  let open_in_out cmd argv input =
    let pid,(in_chan,out_chan) = JoinProc.open_in_out cmd argv in
    debug "TEXT" "START %i" pid ;
    def waited(st) & waitpid(k) = waited(st) & k(st) in
    let out = of_text in_chan in
    spawn producer_to_chan (input,out_chan) ;
    add_kill_wait pid [out] [out_chan] waited waitpid { et with out; }


  let open_full cmd argv input =
    let pid,(in_chan, out_chan,err_chan) = JoinProc.open_full cmd argv in
    debug "TEXT" "START %i" pid ;
    def waited(st) & waitpid(k) = waited(st) & k(st) in
    let out = of_text in_chan
    and err = of_text err_chan in
    spawn producer_to_chan (input,out_chan) ;
    add_kill_wait pid [out;err] [out_chan] waited waitpid { et with out; err;}

end

module Sync = struct

  type text = string list

  type result =
      { st : Unix.process_status ;
        out : text ;
        err : text ; }

  let er = { st=Unix.WEXITED (-1) ; out=[]; err=[]; }
    
  type t =
      { wait : unit  -> result;
        kill : int -> unit;
        gkill : int -> unit; }


  module P = JoinCom.P

  let list_to_producer = P.of_list

  def consume (prod,k) =
    P.to_list(prod,def kk(xs) = prod.P.kill() & k(xs) in kk) 

  let fst xs = match xs with
  | x::_ -> x
  | [] -> ""

  let tagsync = "SYNC"

  let verb tag k =
     def v(r) =  debug tagsync "%s: %s" tag (fst r) ; k(r) in v

  let command cmd argv =
    let ext = Async.command cmd argv in
    def wait_ter() & waitpid(st) =
      reply { er with st=st; } to wait_ter in
    let () = spawn ext.Async.waitpid(waitpid) in
    { wait=wait_ter; kill=ext.Async.kill; gkill=ext.Async.gkill; }

  let open_in cmd argv =
    let ext = Async.open_in cmd argv in
    def wait_ter() & waitpid(st) & out(os) =
      reply { er with st=st; out=os; } to wait_ter in
    let () = spawn begin
      consume(ext.Async.out,verb "OUT" out) &
      ext.Async.waitpid(waitpid)
    end in
    { wait=wait_ter; kill=ext.Async.kill; gkill=ext.Async.gkill; }


  let open_in_out cmd argv =
    let f = Async.open_in_out cmd argv in
    def fork(input) =
      let ext = f(list_to_producer(input)) in
      def wait_ter() & waitpid(st) & out(os) =
        reply { er with st=st; out=os; } to wait_ter in
      consume(ext.Async.out,verb "OUT" out) &
      ext.Async.waitpid(waitpid) &
      reply { wait=wait_ter; kill=ext.Async.kill; gkill=ext.Async.gkill;}
       to fork in
    fork


  let open_full cmd argv =
    let f = Async.open_full cmd argv in
    def fork(input) =
      let ext = f(list_to_producer(input)) in
      def wait_ter() & waitpid(st) & out(os) & err(es) =
        reply { st=st; out=os; err=es } to wait_ter in
      consume(ext.Async.out,verb "OUT" out) &
      consume(ext.Async.err,verb "ERR" err) &
      ext.Async.waitpid(waitpid) &
      reply { wait=wait_ter; kill=ext.Async.kill; gkill=ext.Async.gkill; }
      to fork in
    fork
end
