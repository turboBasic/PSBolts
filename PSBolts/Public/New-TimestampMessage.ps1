function New-TimestampMessage {
    <#

    .SYNOPSIS
Generates a message with timestamp

    #>

    #region function metadata

    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory,
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName )]
        [String[]]
        $Message
    )

    #endregion


    BEGIN {}

    PROCESS {
        foreach ($oneMessage in $Message) {
            '[{0}] {1}' -f (Get-Date -UFormat '%Y-%m-%d %H:%M:%S'), $oneMessage;
        }
    }

    END {}

}
