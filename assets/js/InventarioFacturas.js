class InventarioFacturas {
    // Constructor
    constructor(facturas, t) {
        this.facturas = facturas || new Array();
        this.t = t || null;
    }

    CargaFacturas(){
        $.ajax({
            type: "POST",
            url: "class/Factura.php",
            data: {
                action: "ReadAll"
                }
            })
        .done(function(e){
            inventarioFacturas.drawFac(e)
        });
    }

    drawFac(e){
        var data = JSON.parse(e);
        var facturas = data;
    
        this.t = $('#tb_facturas').DataTable( {
            data: facturas,
            "order": [[ 0, "desc" ]],
            columns: [
                {
                    title: "#Factura",
                    data: "consecutivo"
                },
                {
                    title: "Fecha",
                    data: "fechaCreacion"
                },
                {
                    title: "Almacen",
                    data: "nombre"
                },
                {
                    title: "Vendedor",
                    data: "userName"
                },
                {
                    title: "Total",
                    data: "totalVenta"
                },
            ]
        });    
    };
}

//Class Instance
let inventarioFacturas = new InventarioFacturas();

$(document).ready( function() {
    inventarioFacturas.CargaFacturas();
});