$procent = 90
function Get_Procent {
  param ($_item_size,$_total_item_size)
  $_return = ($_item_size * 100) / $_total_item_size
  return [math]::Round($_return)
}

function Obj_to_int64 {
  param ($ParameterObject)
  if ($null -eq $ParameterObject){continue}
  $_split_string = (($ParameterObject.ToString()).split("(")) -replace '[a-z), ]'
  $_result = [long]$_split_string[1]
  return $_result
}




$e = ForEach-Object {get-mailbox -ResultSize Unlimited}
foreach ($i in $e)
{
  $alias = $i.Alias
  if ($alias -eq "info"){continue}
  try {$get_total_item_size = obj_to_int64 -parameterobject ((get-mailboxstatistics $alias).TotalItemSize.value)}
  catch {continue}
  $ProhibitSendQuota = $null
  if ($i.ProhibitSendQuota -eq "Unlimited"){$ProhibitSendQuota = (get-mailboxstatistics $alias).DatabaseProhibitSendQuota.value} else {$ProhibitSendQuota = $i.ProhibitSendQuota}
  $ProhibitSendQuota = obj_to_int64 -parameterobject $ProhibitSendQuota
  $alert_message = $alias + " ALERT!"
  if ((Get_Procent -_item_size $get_total_item_size -_total_item_size $ProhibitSendQuota) -ge $procent) {Write-Output $alert_message}
}










trap [DivideByZeroException] {
  Write-Host 'divide by zero trapped'
  5/0
}

$e = @($null,9,1,2)
foreach ($i in $e) {
  if ($null -eq $i){continue}
  90/$i
}

Write-Output $alias
if ($null -eq $ParameterObject){$ParameterObject = 0}