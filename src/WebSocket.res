type url
type socket = {@set"auth":{"username":string, "protocolname":string, "rolenames":array<string>}}
type message = {from_username:string, content:string}
@module("socket.io-client") external io: (. 'a, 'c) => socket = "io"
@new external createURL: string => url = "URL"
@send external connect : socket => unit = "connect";
@send external emit : (socket, string, 'a) => unit = "emit";
@send external on : (socket, string, 'a => 'b) => unit = "on"; 