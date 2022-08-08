function slide()
{
    if (document.getElementById("sidebar").style.left != '100%')
    document.getElementById("sidebar").style.left = '100%';
    else document.getElementById("sidebar").style.left = '65%';
}
let visible = false;
function openbadge(){
    if(!visible) {
        document.getElementById("badge").style.display = 'inline-block';
        visible = true;
    }
    else {
        document.getElementById("badge").style.display = 'none';
        visible = false;
    }
}