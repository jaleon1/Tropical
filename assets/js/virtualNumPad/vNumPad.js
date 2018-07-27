var selector = "";

function sendVal(a){
    // a=parseInt(a);
    switch (a) {
        case ((a>=0 && a<=9)?a:-1):
           addNumber(a);
            break;
        case ("enter"):
            enter();
            break;
        case ("left"):
            left();
            break;
        default:
            return false
    };    
};

function addNumber(a){
    selector.val(selector.val()+a);     
};

function left(){
    t=selector.val();
    selector.val(t.substring(0,t.length-1)); 
};

function enter(){
    $('#numPad').fadeOut('slow');
};