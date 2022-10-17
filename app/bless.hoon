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
=|  state
=*  state  -
^-  agent:gall
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
  |=  =vase
  ^-  (quip card _this)
  `this(state !<(_state vase))
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  |^
  ?+    mark  (on-poke:def mark vase)
      %handle-http-request
    ?>  =(src.bowl our.bowl)
    =^  cards  state
      (handle-http !<([@ta =inbound-request:eyre] vase))
    [cards this]
    ::
      %bless-action
    =/  action  !<(?(action:bless vase))
    ?-    -.action
        %send-blessing
      ?>  =(src.bowl our.bowl)
      ?>  (lte our.bowl 0xffff.ffff)
      :_  this(linked [~ ship:action])
      :~  [%pass /bless %agent [ship:action %bless] %poke %bless-action !>(%bless)]
      ==
      ::
        %send-unblessing
      ?>  =(src.bowl our.bowl)
      ?>  (lte our.bowl 0xffff.ffff)
      :_  this(linked [~])
      :~  [%pass /bless %agent [ship:action %bless] %poke %bless-action !>(%unbless)]
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
        




      
  ==
++  on-peek  on-peek:def
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-agent  on-agent:def
++  on-arvo  on-arvo:def
++  on-fail  on-fail:def
--