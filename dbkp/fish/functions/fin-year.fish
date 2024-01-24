function fin-year --argument-names year
  if test -z "$year"
    set year (date +%Y)
  end
  hledger -f ~/.org/finances/$year.ledger is -MAS -2 date:$year/01-$year/12/31
end
