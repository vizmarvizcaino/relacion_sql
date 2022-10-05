CREATE TABLE carro (
id SERIAL INT PRIMARY KEY,
modelo VARCHAR(25),
marca VARCHAR(25),
precio NUMERIC(15),
stock VARCHAR(25)
);

CREATE TABLE pedido (
id SERIAL PRIMARY KEY,
cliente_id INT,
carro_id INT,
cantidad NUMERIC(10),
fecha_pedido DATE NOT NULL DEFAULT CURRENT_DATE,
CONSTRAINT fk_cliente
      FOREIGN KEY(cliente_id) 
	  REFERENCES cliente(id),
CONSTRAINT fk_carro
      FOREIGN KEY(carro_id) 
	  REFERENCES carro(id)
);

CREATE TABLE cliente (
id SERIAL INT PRIMARY KEY,
vendedor_id INT,
nombre VARCHAR(10),
ciudad VARCHAR(10),
valor_pagado NUMERIC(10),
CONSTRAINT fk_vendedor
      FOREIGN KEY(vendedor_id) 
	  REFERENCES vendedor(id)
);

CREATE TABLE vendedor (
id SERIAL INT PRIMARY KEY,
sucursal_id INT,
nombre VARCHAR(10),
apellidos VARCHAR(20),
cargo VARCHAR(10),
fecha_pedido DATE NOT NULL DEFAULT CURRENT_DATE,
sueldo NUMERIC(10),
CONSTRAINT fk_sucursal
      FOREIGN KEY(sucursal_id) 
	  REFERENCES sucursal(id)
);

CREATE TABLE sucursal (
id SERIAL INT PRIMARY KEY,
nombre VARCHAR(10),
ciudad VARCHAR(10)
);

INSERT INTO carro (modelo,marca,precio,stock)
 VALUES('2022','MAZDA CX-5',2800,'5'),
('2022','TOYOTA PRADO',4800,'2');

INSERT INTO sucursal (nombre,ciudad)
 VALUES('Los Coches','Medellin'),
('Todo Carro','Bogota');

INSERT INTO vendedor (sucursal_id,nombre,apellidos,cargo,sueldo)
 VALUES(1,'Juan','Martinez','Vendedor',700),
(2,'Martin','Romero','Vendedor',500);

INSERT INTO cliente (vendedor_id,nombre,ciudad,valor_pagado)
 VALUES(1,'Juan','Neiva',2800),
(2,'Jose','Armenia',4800);

INSERT INTO pedido (cliente_id,carro_id,cantidad)
 VALUES(1,1,1),
(2,2,1);

select p.cliente_id,c2.nombre, c2.ciudad, c2.valor_pagado,c.modelo, c.marca, c.precio,
p.cantidad, p.fecha_pedido, c2.vendedor_id,v.cargo, v.nombre, v.apellidos, v.fecha_pedido, v.sueldo, s.nombre, s.ciudad  
from carro c 
inner join pedido p on p.carro_id = c.id 
inner join cliente c2 on p.cliente_id = c2.id 
inner join vendedor v on c2.vendedor_id = v.id 
inner join sucursal s on v.sucursal_id = s.id 