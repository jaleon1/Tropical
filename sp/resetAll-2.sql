use tropical;
update producto
set saldoCantidad=0, saldoCosto=0, costoPromedio=0, precioVenta=0;
update insumo
set saldoCantidad=0, saldoCosto=0, costoPromedio=0;
-- borra tablas.
delete from historicoComprobante;
delete from inventarioInsumo;
delete from inventarioProducto;
delete from mermaInsumo;
delete from mermaProducto;
delete from consumible;
delete from detalleOrden;
delete from insumosXBodega;
delete from insumosXOrdenCompra;
delete from insumosXOrdenCompraXBodega;
delete from insumosXOrdenSalida;
delete from ordenCompra;
delete from ordenCompraXBodega;
delete from ordenSalida;
delete from productosXDistribucion;
delete from productosXFactura;
delete from productosXOrdenSalida;
delete from distribucion;
delete from factura;
delete from cajasXBodega;
