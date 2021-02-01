function Test-Port
{  
    [Cmdletbinding()]
    Param(  
        [Parameter(Mandatory, Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string[]]$ComputerName,

        [Parameter(Mandatory, Position = 1, ValueFromPipelineByPropertyName)]
        [int]$Port,

        [int]$Count = 1,

        [int]$Delay = 500,
        
        [int]$TcpTimeout = 1000,
        [int]$UdpTimeout = 1000,
        [switch]$Tcp,
        [switch]$Udp
    )

    begin
    {  
        if (-not $Tcp -and -not $Udp)
        {
            $Tcp = $true
        }
        #Typically you never do this, but in this case I felt it was for the benefit of the function  
        #as any errors will be noted in the output of the report          
        $ErrorActionPreference = 'SilentlyContinue'
        $report = @()

        $sw = New-Object System.Diagnostics.Stopwatch
    }

    process
    {
        foreach ($c in $ComputerName)
        {
            for ($i = 0; $i -lt $Count; $i++) 
            {
                $result = New-Object PSObject | Select-Object Server, Port, TypePort, Open, Notes, ResponseTime
                $result.Server = $c
                $result.Port = $Port
                $result.TypePort = 'TCP'

                if ($Tcp)
                {
                    $tcpClient = New-Object System.Net.Sockets.TcpClient
                    $sw.Start()
                    $connect = $tcpClient.BeginConnect($c, $Port, $null, $null)
                    $wait = $connect.AsyncWaitHandle.WaitOne($TcpTimeout, $false)
                    
                    if (-not $wait)
                    {
                        $tcpClient.Close()
                        $sw.Stop()

                        $result.Open = $false
                        $result.Notes = 'Connection to Port Timed Out'
                        $result.ResponseTime = $sw.ElapsedMilliseconds
                    }
                    else
                    {
                        try
                        {
                            [void]$tcpClient.EndConnect($connect)
                            $tcpClient.Close()
                            $sw.Stop()

                            $result.Open = $true
                        }
                        catch
                        {
                            $result.Open = $false
                        }
                    }

                    $result.ResponseTime = $sw.ElapsedMilliseconds
                }
                if ($Udp)
                {
                    $udpClient = New-Object System.Net.Sockets.UdpClient
                    $udpClient.Client.ReceiveTimeout = $UdpTimeout

                    $a = New-Object System.Text.ASCIIEncoding
                    $byte = $a.GetBytes("$(Get-Date)")

                    $result.Server = $c
                    $result.Port = $Port
                    $result.TypePort = 'UDP'

                    Write-Verbose 'Making UDP connection to remote server'
                    $sw.Start()
                    $udpClient.Connect($c, $Port)
                    Write-Verbose 'Sending message to remote host'
                    [void]$udpClient.Send($byte, $byte.Length)
                    Write-Verbose 'Creating remote endpoint'
                    $remoteEndpoint = New-Object System.Net.IPEndPoint([System.Net.IPAddress]::Any, 0)

                    try
                    {
                        Write-Verbose 'Waiting for message return'
                        $receiveBytes = $udpClient.Receive([ref]$remoteEndpoint)
                        $sw.Stop()
                        [string]$returnedData = $a.GetString($receiveBytes)
                        
                        Write-Verbose 'Connection Successful'
                            
                        $result.Open = $true
                        $result.Notes = $returnedData
                    }
                    catch
                    {
                        Write-Verbose 'Host maybe unavailable'
                        $result.Open = $false
                        $result.Notes = 'Unable to verify if port is open or if host is unavailable.'
                    }
                   finally
                    {
                        $udpClient.Close()
                        $result.ResponseTime = $sw.ElapsedMilliseconds
                    }
                }

                $sw.Reset()
                $report += $result

                Start-Sleep -Milliseconds $Delay
            }
        }
    }

    end
    {
        $report 
    }
} 
