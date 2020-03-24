import XMonad (launch, def, modMask, terminal, mod4Mask)


main = do
  launch def
    { modMask = mod4Mask -- Use Super instead of Alt
    , terminal = "urxvt" }

