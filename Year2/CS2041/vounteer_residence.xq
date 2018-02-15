// Works on volunteerDatabase.xml
// Returns any volunteer living in rolando
  
for $so in
doc('volunteerDatabase.xml')//volunteer
   
let $s := (substring($so/address/city, 1))
let $n :=(substring($so/name, 1))
let $z :=(substring($so/contactInfo/phoneNumber, 1))
where ($s= "Rolando")
return ($n, $z)
  
