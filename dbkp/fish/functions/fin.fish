function fin
  set -l year (date +%Y)
  set -l date (grep '* Salaire' ~/.org/finances/$year.ledger | awk '{print $1}' | tail -n 1 | string split /)
  if test -n "$date"
    set date $date[2]/$date[3]
  else
    set date $year/01
  end
  echo date: $date
  ledger -f ~/.org/finances/$year.ledger bal Bank:Checking
  ledger -f ~/.org/finances/$year.ledger bal Bank:Saving
  echo '===================='
  ledger -f ~/.org/finances/$year.ledger bal -b $date Expenses
end
