XPTemplate priority=personal 

XPTinclude 
    \ html/html
XPT field
<div class=field>
XSET type=ChooseStr( 'text', 'password', 'checkbox', 'radio', 'submit', 'reset', 'file', 'hidden', 'image', 'button' )
    <label for=`name^/>
    <input type=`type^ name=`name^ value=`value^ >
</div>
..XPT
