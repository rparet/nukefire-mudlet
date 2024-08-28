* security glyph
if %cmd% == touch || %cmd% == touc || %cmd% == tou
  set roomNum %self.room.vnum%
  set roomKeyMap[22610] 22509
  set roomKeyMap[22596] 22524
  set roomKeyMap[22598] 22525
  set roomKeyMap[22595] 22526
  set roomKeyMap[22597] 22527
  set key %%roomKeyMap[%roomNum%]%%
  eval key %key%
  if %actor.pos% == sleeping
    %send% %actor% In your dreams, or what?
  elseif %actor.pos% == fighting
    %send% %actor% You're a little busy right now!
  elseif %actor.pos% == sitting
    %send% %actor% Maybe you should get on your feet first?
  else
    if %arg% == glyph || %arg% == glyp || %arg% == gly || %arg% == gl
      %send% %actor% You curiously touch a security glyph.
      %echoaround% %actor% %actor.name% curiously touches %self.shortdesc%.
      if %key% && %actor.inventory(%key%)%
        %send% %actor% %self.shortdesc% briefly shimmers with a green light before dissolving before your eyes.
        %send% %actor% The monofilament security barrier seems to dissolve along with it.
        %echoaround% %actor% %self.shortdesc% and the monofilament barrier dissolve into the ether!
        %purge% %actor.inventory(%key%)%
        %purge% %self%
      else
        %echo% %self.shortdesc% pulses and briefly flashes @Rred@n. A hollow vibration emanates from the walls.  
      end
    else
      %send% %actor% You can't touch that person, they don't exist.
    end
  end
else 
  return 0
end

* security barrier
switch %self.vnum%
  case 22610
    if %direction% == east || %direction% == west
      set blocked true
    end
    break
  case 22596
    if %direction% == east
      set blocked true
    end
    break
  case 22598
    if %direction% == west
      set blocked true
    end
    break
  case 22595
   if %direction% == north
    set blocked true
   end
   break
  case 22597
    if %direction% == south
     set blocked true
    end
    break
done

if %self.contents(22508)% && %blocked% == true
 %send% %actor% A shimmering barrier of monofilament threads blocks your path.
 return 0
end

* mana leech

set vict %random.char%

if %vict% && %vict.is_pc%
  eval drain %vict.maxmana% / 4
  if %vict.mana% > %drain%
    %send% %vict% %self.name% @[f030]gl@[f040]ows@[f051] brig@[f152]htl@[f253]y@n - you feel your part of your energy being pulled away from you!
    %echoaround% %vict% %self.name% @[f030]gl@[f040]ows@[f051] brig@[f152]htl@[f253]y@n - %vict.name% looks slightly drained!
    nop %vict.mana(-%drain%)%
  end
end


* nanomite trap
%send% %actor% As you move to exit @[f111]dark@[f112] nanomi@[f113]tes@n swirl around your legs, preventing your escape!
%echoaround% %actor% %actor.name% tries to move but @[f111]dark@[f112] nanomi@[f113]tes@n swirl around %actor.hisher% legs, preventing %actor.hisher% exit!
return 0

