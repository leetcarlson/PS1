        {
        write-host $_.Exception.GetType().FullName; 
        write-host $_.Exception.Message;
        write-host $_.Exception.Line;
        write-host $_.Exception.ErrorID;
        write-host $_.Exception.ErrorRecord;    
        }