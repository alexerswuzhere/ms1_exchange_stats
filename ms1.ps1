$procent = 40

function Get_Procent {
  param ($_item_size,$_total_item_size)
  $_return = 
}



function Obj_to_int64 {
  param ($ParameterObject)
  $result = $null
  $result = (($ParameterObject.ToString()).split("(")) -replace '[a-z), ]'
  return [long]$result[1]
}


$e = ForEach-Object {get-mailbox -resultsize 50}
foreach ($i in $e)
{
  $alias = $i.Alias
  $get_total_item_size = obj_to_int64 -parameterobject ((get-mailboxstatistics $alias).TotalItemSize.value)
  $ProhibitSendQuota = $null
  if ($i.ProhibitSendQuota -eq "Unlimited"){$ProhibitSendQuota = (get-mailboxstatistics $alias).DatabaseProhibitSendQuota.value} else {$ProhibitSendQuota = $i.ProhibitSendQuota}
  $ProhibitSendQuota = obj_to_int64 -parameterobject $ProhibitSendQuota
  Write-output $alias,$get_total_item_size, $ProhibitSendQuota,$get_total_item_size.Gettype().Fullname,$ProhibitSendQuota.Gettype().Fullname
  if ($get_total_item_size -lt $ProhibitSendQuota){Write-Output "TRUE"} else {Write-Output "false"}
}

