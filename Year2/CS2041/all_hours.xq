// It returns the number 29 which is all the hours total volunteers can work this week.
// Has a user defined function and for function 

declare function local:all_hours()
{
  for $s in
  doc('volunteerDatabase.xml')
  return
  sum($s//volunteer/accountAccess/hoursAvailable)
};
local:all_hours()

