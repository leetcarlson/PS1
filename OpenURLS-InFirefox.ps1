<#
This is a snippet of code I used to launch several webpages in firefox rapid succession to test onbase access.
All you need to do is to change the URLS in the array to launch your pages.
#>

$FirefoxLocation = "C:\Program Files (x86)\Mozilla Firefox\firefox.exe"
$URLS = @('https://onbase.iu.edu/appnet/','https://onbase.iu.edu/docpop_kfs/docpop/docpop.aspx?clienttype=html&docid=949847','https://onbase.iu.edu/docpop_adm/docpop/docpop.aspx?clienttype=html&docid=949847','https://onbase.iu.edu/docpop_kfs/docpop/docpop.aspx?clienttype=html&docid=949847','https://onbase.iu.edu/docpop_risk/docpop/docpop.aspx?clienttype=html&docid=949847','https://onbase.iu.edu/docpop_tvl/docpop/docpop.aspx?clienttype=html&docid=949847','https://onbase.iu.edu/docpop_uhrs/docpop/docpop.aspx?clienttype=html&docid=949847','https://onbase.iu.edu/docpop_uhrswc/docpop/docpop.aspx?clienttype=html&docid=949847')

foreach($URL in $URLS)
{
    start $FirefoxLocation $URL
}