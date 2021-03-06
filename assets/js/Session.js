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
                    Session.sideBarDraw(data);
                    $(".main_container").removeAttr("style");
                    break;
                case 'nocredencial':
                    $('.right_col').hide();
                    Session.setUsername(data.username, data.nombre);      
                    Session.setMenu(data.eventos);    
                    Session.state=false;
                    alert('El usuario no tiene credenciales para ver esta página.');
                    /*swal({
                        //
                        type: 'error',
                        title: 'El usuario no tiene credenciales para ver esta página.',
                        showConfirmButton: false,
                        timer: 3000
                    });*/
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
            '<img src="images/logoTropical.png" alt="" > ' + un+ ' ' + 
            '<span class=" fa fa-angle-down" ></span> '        
        );
        $('#call_name').text(n);
        // bodega
        $('.call_Bodega').text(b);

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
            <li id="Hacienda" style="display:none;">
                <a> <i class="fa fa-cog"></i> Hacienda
                    <span class="fa fa-chevron-down"></span>
                </a>
                <ul class="nav child_menu"> </ul>
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
    },
    sideBarDraw(dataMenu) {

        if ( $("#sidebar-menu").length ) {

            $("#sidebar-menu").empty();
    
            var menu_section =
                `<div class="menu_section">
                <h3>${dataMenu.bodega}</h3>
                <ul id="menu" class="nav side-menu">
                    
                </ul>
            </div>`;
            $("#sidebar-menu").append(menu_section);
    
            $.each(dataMenu.eventos, function (i, item) {
                if ($('#' + item.menuPadre).length) {
                    if(!$('#' + item.id).length){
                    var link =
                        ` <li id="${item.id}"><a href="${item.url}">${item.nombre}</a></li>`;
                    $("#list_" + item.menuPadre).append(link);
                    }
                } else {
                    var menu =
                        `<li id="${item.menuPadre}" ><a><i class="${item.icono}"></i> ${item.menuPadre} <span class="fa fa-chevron-down"></span></a>
                            <ul id="list_${item.menuPadre}" class="nav child_menu">
                                <li id="${item.id}"><a href="${item.url}">${item.nombre}</a></li>
                            </ul>
                        </li>`;
                    $("#menu").append(menu);
                }
            });  
            //
            if (typeof init_sidebar === "function") 
                init_sidebar();
            else {
                setTimeout(function(){
                    Session.sideBarDraw(dataMenu);               
                 }, 500);                
            }
        }
    }







}