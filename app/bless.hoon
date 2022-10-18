/-  bless
/+  dbug, default-agent, server, schooner
/*  planet-ui  %html  /app/planet-ui/html
/*  comet-ui  %html  /app/comet-ui/html
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0  [%0 linked=(unit @p)]
+$  card  card:agent:gall
--
%-  agent:dbug
^-  agent:gall
=|  state-0
=*  state  -
|_  =bowl:gall
+*  this  .
    def  ~(. (default-agent this %.n) bowl)
++  on-init
  ^-  (quip card _this)
  :_  this(linked [~])
  :~
    :*  %pass  /eyre/connect  %arvo  %e
        %connect  `/apps/bless  %bless
    ==
  ==
::
++  on-save
  ^-  vase
  !>(state)
::
++  on-load
  |=  old-state=vase
  ^-  (quip card _this)
  =/  old  !<(versioned-state old-state)
  ?-  -.old
    %0  `this(state old)
  ==
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  |^
  ?+    mark  (on-poke:def mark vase)
      %bless-action
    =/  action  !<(action:bless vase)
    =^  cards  state
      (handle-action action)
    [cards this]
    ::
      %handle-http-request
    ?>  =(src.bowl our.bowl)
    =^  cards  state
      (handle-http !<([@ta =inbound-request:eyre] vase))
    [cards this]
  ==
  ++  handle-http
    |=  [eyre-id=@ta =inbound-request:eyre]
    ^-  (quip card _state)
    =/  ,request-line:server
      (parse-request-line:server url.request.inbound-request)
    =+  send=(cury response:schooner eyre-id)
    ?.  authenticated.inbound-request
      :_  state
      %-  send
      [302 ~ [%login-redirect './apps/bless']]
    ::
    ?+    method.request.inbound-request  
      [(send [405 ~ [%stock ~]]) state]
      ::
        %'POST'
      ?~  body.request.inbound-request
        [(send [405 ~ [%stock ~]]) state]
      =/  json  (de-json:html q.u.body.request.inbound-request)
      =/  action  (dejs-action +.json)
      (handle-action action) 
      :: 
        %'GET'
      ?+    site  
          :_  state 
          (send [404 ~ [%plain "404 - Not Found"]])
        ::
          [%apps %bless ~]
        :_  state
        %-  send
        :+  200  ~  
        :-  %html
        ?:  (lte our.bowl 0xffff.ffff)
          planet-ui
        comet-ui
        ::
          [%apps %bless %state ~]
        :_  state
        %-  send
        :+  200  ~ 
        [%json (enjs-state +.state)]
      == 
    ==
  ::
  ++  enjs-state
    =,  enjs:format
    |=  state=(unit @p)
    ^-  json
    ?^  state
      (ship +:state)
    (numb 0)
  ::
  ++  dejs-action
    =,  dejs:format
    |=  jon=json
    ^-  action:bless
    %.  jon
    %-  of
    :~  send-blessing+(se %p)
        send-unblessing+(se %p)
        investigate+(se %p)
    ==
  ::
  ++  handle-action
    |=  =action:bless
    ^-  (quip card _state)
    ?-    -.action
        %send-blessing
      ?>  =(src.bowl our.bowl)
      ?>  (lte our.bowl 0xffff.ffff)
      ?>  (gte ship:action 0x1.0000.0000)
      :_  state(linked [~ ship:action])
      :~  [%pass /blessing %agent [ship:action %bless] %poke %bless-action !>([%bless ~])]
      ==
      ::
        %send-unblessing
      ?>  =(src.bowl our.bowl)
      ?>  (lte our.bowl 0xffff.ffff)
      ?>  (gte ship:action 0x1.0000.0000)
      :_  state(linked [~])
      :~  [%pass /blessing %agent [ship:action %bless] %poke %bless-action !>([%unbless ~])]
      ==
      ::
        %bless
      ?>  ?!  =(src.bowl our.bowl)
      ?>  (gte our.bowl 0x1.0000.0000)
      ?>  (lte src.bowl 0xffff.ffff)
      ?>  =(linked [~])
      `state(linked [~ src.bowl])
      ::
        %unbless
      ?>  ?!  =(src.bowl our.bowl)
      ?>  (gte our.bowl 0x1.0000.0000)
      ?>  (lte src.bowl 0xffff.ffff)
      ?>  ?!  =(linked [~])
      ?>  =(+.linked src.bowl)
      `state(linked [~])
      ::
        %investigate
      ?>  =(src.bowl our.bowl)
      ?>  (lte our.bowl 0xffff.ffff)
      ?>  (gte ship:action 0x1.0000.0000)
      :_  state
      :~  [%pass /investigate %agent [ship:action %bless] %watch /confession]
      ==
    ==
  --
::
++  on-peek  on-peek:def
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?+    path  (on-watch:def path)
      [%confession ~]
    :_  this
    :~  ?:  =(linked [~])
          [%give %fact ~ %bless-confession !>(`confession:bless`%.n)]
        [%give %fact ~ %bless-confession !>(`confession:bless`%.y)]
        [%give %kick ~[/confession] ~]
    ==
    ::
      [%http-response *]
    `this
  ==
::
++  on-leave  on-leave:def
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?+    wire  (on-agent:def wire sign)
      [%blessing ~]
    ?>  =(%poke-ack -.sign)
    (on-agent:def wire sign)
    ::
      [%investigate ~]
    ?+    -.sign  (on-agent:def wire sign)
        %fact
      ?+    p.cage.sign  (on-agent:def wire sign)
          %bless-confession
        ?:  !<(confession:bless q.cage.sign)
          ~&  >  "{(scow %p src.bowl)} is blessed!"
          `this
        ~&  >>>  "{(scow %p src.bowl)} is not blessed."
        `this
      ==
    ==
  ==
::
++  on-arvo  on-arvo:def
++  on-fail  on-fail:def
--