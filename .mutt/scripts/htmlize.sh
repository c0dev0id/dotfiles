#!/bin/sh
# read stdin
content=$(cat)
content_safe=$(echo "$content"| sed -E 's/^(>+)/\1 /g ;
                                        s/^(>+)  /\1 /g ;
                                        s|<|\&lt;|g ;
                                        s|>|\&gt;|g ;
                                        s|^\&gt;\&gt;\&gt;\&gt;\&gt;\&gt;|\&gt;\&gt;\&gt;\&gt;\&gt;</span><span style="color: x">\&gt;</span>|g ;
                                        s|^\&gt;\&gt;\&gt;\&gt;\&gt;|\&gt;\&gt;\&gt;\&gt;</span><span style="color: gray">\&gt;</span>|g ;
                                        s|^\&gt;\&gt;\&gt;\&gt;|\&gt;\&gt;\&gt;</span><span style="color: brown">\&gt;</span>|g ;
                                        s|^\&gt;\&gt;\&gt;|\&gt;\&gt;</span><span style="color: green">\&gt;</span>|g ;
                                        s|^\&gt;\&gt;|\&gt;<span style="color: orange">\&gt;</span>|g ;
                                        s|^\&gt;|<span style="color: blue">\&gt;</span>|g ;
                                        s|^----------.*|<span style="color: gray">&</span>| ;
                                        s|^Sender: |<b>&</b>| ;
                                        s|^Date: |<b>&</b>| ;
                                        s|^To: |<b>&</b>| ;
                                        s|^Cc: |<b>&</b>| ;
                                        s|^Subject: |<b>&</b>| ;
                                        s|^-- $|</font><font face="Arial" size="0.75" color="gray">--\&nbsp;|g ;
                                        s|^Stefan Hagen$|<b>&</b>|g ;
                                        s|^SAP SE Germany, Walldorf$|<b>&</b>|g')

# wrap html
echo '<html>'
echo '  <head>'
echo '    <meta charset="utf-8">'
echo '    <meta name="viewport" content="width=device-width, initial-scale=1">'
echo '    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">'
echo '    <meta http-equiv="X-UA-Compatible" content="IE=edge">'
echo '    <title></title>'
echo '  </head>'
echo '  <body style="min-width: 74ch; color: black; font-size: 11; line-height: 1.6; font: 11, \"Calibri\"">'
echo ' <pre>'
echo ' <font size="3" face="Calibri">'
echo "$content_safe"
echo '</font>'
echo '</pre>'
echo '</body>'
echo '</html>'
