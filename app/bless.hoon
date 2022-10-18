/-  bless
/+  dbug, default-agent, server, schooner
/*  bless-ui  %html  /app/bless-ui/html
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0  linked=(unit @p)
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
  =/  old  !<(state-0 old-state)
  `this(state old)
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ::|^
  ?+    mark  (on-poke:def mark vase)
   ::   %handle-http-request
   :: ?>  =(src.bowl our.bowl)
   :: =^  cards  state
   ::   (handle-http !<([@ta =inbound-request:eyre] vase))
   :: [cards this]
    ::
      %bless-action
    =/  action  !<(action:bless vase)
    ?-    -.action
        %send-blessing
      ?>  =(src.bowl our.bowl)
      ?>  (lte our.bowl 0xffff.ffff)
      :_  this(linked [~ ship:action])
      :~  [%pass /blessing %agent [ship:action %bless] %poke %bless-action !>(%bless)]
      ==
      ::
        %send-unblessing
      ?>  =(src.bowl our.bowl)
      ?>  (lte our.bowl 0xffff.ffff)
      :_  this(linked [~])
      :~  [%pass /blessing %agent [ship:action %bless] %poke %bless-action !>(%unbless)]
      ==
      ::
        %bless
      ?>  ?!  =(src.bowl our.bowl)
      ?>  (gte our.bowl 0x1.0000.0000.0000.0000)
      ?>  (lte src.bowl 0xffff.ffff)
      ?>  =(linked [~])
      `this(linked [~ src.bowl])
      ::
        %unbless
      ?>  ?!  =(src.bowl our.bowl)
      ?>  (gte our.bowl 0x1.0000.0000.0000.0000)
      ?>  (lte src.bowl 0xffff.ffff)
      ?>  ?!  =(linked [~])
      ?>  =(+.linked src.bowl)
      `this(linked [~])
      ::
        %investigate
      ?>  =(src.bowl our.bowl)
      ?>  (lte our.bowl 0xffff.ffff)
      :_  this
      :~  [%pass /investigate %agent [ship:action %bless] %watch /confession]
      ==
    ==
  ==
::
++  on-peek  on-peek:def
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?+    path  (on-watch:def path)
      [%investigate ~]
    :_  this
    :~  ?:  =(linked [~])
          [%give %fact ~ %bless-confession !>(`confession:bless`%.n)]
        [%give %fact ~ %bless-confession !>(`confession:bless`%.y)]
        [%give %kick ~[/investigate] ~]
    ==
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
    ?>  =(%fact -.sign)
    ?>  =(%bless-confession p.cage.sign)
    ?:  !<(confession:bless q.cage.sign)
      ~&  "{(scow %p src.bowl)} is blessed!"
      `this
    ~&  "{(scow %p src.bowl)} is not blessed."
    `this
  ==
::
++  on-arvo  on-arvo:def
++  on-fail  on-fail:def
--