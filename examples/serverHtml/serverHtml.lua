srv = net.createServer(net.TCP)
srv:listen(80, function(conn)
  conn:on("receive", function(sck, payload)
    print(payload)
    local buf = "";
    buf = buf.."<!DOCTYPE html>";
    buf = buf.."<html lang=\"en\">";
    buf = buf.."<head>";
    buf = buf.."  <meta charset=\"UTF-8\">";
    buf = buf.."  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">";
    buf = buf.."  <meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\">";
    buf = buf.."  <title>Document</title>";
    buf = buf.."  <link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/icon?family=Material+Icons\">";
    buf = buf.."  <link rel=\"stylesheet\" href=\"https://code.getmdl.io/1.3.0/material.indigo-pink.min.css\">";
    buf = buf.."  <script defer src=\"https://code.getmdl.io/1.3.0/material.min.js\"></script>";
    buf = buf.."</head>";
    buf = buf.."<body>";
    buf = buf.."  <a id=\"btn\">";
    buf = buf.."    <label class=\"mdl-switch mdl-js-switch mdl-js-ripple-effect\" for=\"switch-1\">";
    buf = buf.."      <input type=\"checkbox\" id=\"switch-1\" class=\"mdl-switch__input\" >";
    buf = buf.."      <span class=\"mdl-switch__label\"></span>";
    buf = buf.."    </label>";
    buf = buf.."  </a>";
    buf = buf.."";
    buf = buf.."  <script>";
    buf = buf.."";
    buf = buf.."    document.getElementById('switch-1').onclick = () => { ";
    buf = buf.."      document.getElementById('btn').href=`?led=${document.getElementsByClassName('mdl-switch__input')[0].checked}`";
    buf = buf.."    }";
    buf = buf.."";
    buf = buf.."  </script>";
    buf = buf.."</body>";
    buf = buf.."</html>";

    -- print(string.match(payload, '(%w+)=(%w+)&*'))
    sck:send(buf)
    --sck:close();
    collectgarbage();
    
  end)
  conn:on("sent", function(sck) sck:close() end)
end)