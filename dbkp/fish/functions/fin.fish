function fin
  set -l date (grep '* Salaire' ~/.org/finances/2025.ledger | awk '{print $1}' | tail -n 1 | string split /)
  set -l date $date[2]/$date[3]
  ledger -f ~/.org/finances/2025.ledger bal Bank:Checking
  ledger -f ~/.org/finances/2025.ledger bal Bank:Saving
  echo '===================='
  ledger -f ~/.org/finances/2025.ledger bal -b $date Expenses
end
