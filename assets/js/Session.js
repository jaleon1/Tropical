var Session=  {
    state: undefined,
    Check(){
        Session.state=undefined
        $.ajax({           
            type: "POST",
            url: "class/Usuario.php",
            data: {
                action: 'CheckSession',
                url: window.location.href
                // success: function(data) {
                //     return data;
                // }
            }
        })
        .done(function( e ) {
            var data= JSON.parse(e);
            switch(data.status){
                case 'login':
                    $('.right_col').show();
                    Session.setUsername(data.username, data.nombre, data.bodega);
                    Session.setMenu(data.eventos);  
                    Session.state=true;
                    break;
                case 'nocredencial':
                    $('.right_col').hide();
                    Session.setUsername(data.username, data.nombre);      
                    Session.setMenu(data.eventos);    
                    Session.state=false;
                    swal({
                        //
                        type: 'error',
                        title: 'El usuario no tiene credenciales para ver esta página.',
                        showConfirmButton: false,
                        timer: 3000
                    });
                    break;
                case 'invalido':
                    Session.state=false;
                    location.href= 'login.html'; 
                    break;                
            }   
        })    
        .fail(function( e ) {
            showError(e);
            location.href= 'login.html';
        });
    },
    setUsername(un, n, b){
        $('#call_username').html(
            '<img src="images/user.png" alt="" > ' + un+ ' ' + 
            '<span class=" fa fa-angle-down" ></span> '        
        );
        $('#call_name').text(n);
        // bodega
        $('.menuName').text(b);

    },
    setMenu(eventos){        
        $('#menubox').html('');
        $('#menubox').append(`
            <li id="Inventario" style="display:none;">
                <a>
                    <i class="fa fa-reorder"></i> Inventario
                    <span class="fa fa-chevron-down"></span>
                </a>
                <ul class="nav child_menu"></ul>
            </li>
            <li id="Facturacion" style="display:none;">
                <a>
                    <i class="fa fa-money"></i> Facturación
                    <span class="fa fa-chevron-down"></span>
                </a>
                <ul class="nav child_menu"></ul>
            </li>
            <li id="Bodega" style="display:none;">
                <a>
                    <i class="fa fa-folder-open"></i> Bodega
                    <span class="fa fa-chevron-down"></span>
                </a>
                <ul class="nav child_menu"></ul>
            </li>
            <li id="Sistema" style="display:none;">
                <a> <i class="fa fa-cog"></i> Sistema
                    <span class="fa fa-chevron-down"></span>
                </a>
                <ul class="nav child_menu"> </ul>
            </li>
        `);
        // menu segun permisos de usuario.
        $.each(eventos, function (i, item) {
            $('#' + item.menuPadre).css({'display':'block'});
            $('#' + item.menuPadre + ' ul.nav').css({'display':'block'});
            $('#' + item.menuPadre + ' ul.nav').append(`
                <li>
                    <a href="${item.url}">${item.nombre}</a>
                </li>
            `);
        });
        // $('#call_menu').html('');
        // $('#call_menu').css({'display':'block'});
        // $.each(eventos, function (i, item) {
        //     $('#call_menu').append(`
        //         <li>
        //             <a href="${item.url}">${item.nombre}</a>
        //         </li>
        //     `);
        // });
    },  
    End(){
        $.ajax({
            type: "POST",
            url: "class/Usuario.php",
            data: {
                action: 'EndSession'
            }
        })
        .done(function( e ) {
            location.href= 'login.html';
        })    
        .fail(function( e ) {
            showError(e);
            //location.href= 'login.html';
        });
    }
}