foreach ($certPath in $args) {
 $cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($certPath)
 New-SPTrustedRootAuthority -Name $certPath -Certificate $cert
}