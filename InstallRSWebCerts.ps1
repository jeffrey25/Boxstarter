Install-Module -Name AzureRm -Repository PSGallery -Scope CurrentUser -Force
Import-Module AzureRm
Login-AzureRmAccount

$cert = Get-AzureKeyVaultSecret -VaultName 'DefenderKeyVaultDev' -Name 'clt-ppe-rs-microsoft-com'

$certBytes = [System.Convert]::FromBase64String($cert.SecretValueText)
$certCollection = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2Collection
$certCollection.Import($certBytes,$null,[System.Security.Cryptography.X509Certificates.X509KeyStorageFlags]::Exportable)

$password = (Get-AzureKeyVaultSecret -VaultName 'DefenderKeyVaultDev' -Name 'clt-ppe-rs-microsoft-com').SecretValueText
$secure = ConvertTo-SecureString -String $password -AsPlainText -Force

$protectedCertificateBytes = $certCollection.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Pkcs12, $password)
$pfxPath = "C:\rsweb_cert.pfx"
[System.IO.File]::WriteAllBytes($pfxPath, $protectedCertificateBytes)

Import-PfxCertificate -FilePath "C:\rsweb_cert.pfx" Cert:\CurrentUser\My -Password $secure
