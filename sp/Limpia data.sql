use tropical;
delete from detalleOrden;
delete from productosXDistribucion;
delete from productosXFactura;
delete from distribucion;
delete from insumosXBodega;
delete from insumosXOrdenCompra;
delete from insumosXOrdenCompraXBodega;
delete from insumosXOrdenSalida;
-- delete from insumo;
delete from ordenCompraXBodega;
delete from ordenCompra;
delete from ordenSalida;
delete from preciosXBodega;
INSERT INTO `tropical`.`preciosXBodega`
(`id`,
`idBodega`,
`tamano`,
`precioVenta`)
VALUES
(uuid(),
'72a5afa7-dcba-4539-8257-ed1e18b1ce94',
'1',
0);
INSERT INTO `tropical`.`preciosXBodega`
(`id`,
`idBodega`,
`tamano`,
`precioVenta`)
VALUES
(uuid(),
'72a5afa7-dcba-4539-8257-ed1e18b1ce94',
'0',
0);
-- delete from producto;
delete from factura;
delete from rolesXUsuario where idUsuario!='1ed3a48c-3e44-11e8-9ddb-54ee75873a60';
delete from usuariosXBodega where idUsuario!='1ed3a48c-3e44-11e8-9ddb-54ee75873a60';
delete from usuario where username!='admin';





