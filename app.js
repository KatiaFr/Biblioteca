//Trabajo Práctico Unidad 3 y 4 Grupo "Q" 
//Alumnos: Katia Fragazzini, Andrés Leonangeli, Emiliano Bajamón


const express = require("express");
const app = express();
const mysql = require("mysql");
const util = require("util");
const cors=require("cors");

app.use(express.json());
app.use(cors());
const port = 3002;


//Conexión con la base de datos:
const conexion = mysql.createConnection({
    host: "localhost",
    user: "root",
    database: "biblioteca",
});

//Callback que responde en caso de error
conexion.connect((error) => {
    if (error) {
        throw error;
    }
    console.log("Conexión con la base de datos mysql establecida");
});


//Permite el uso de async-away en la conexión mysql. Aquí se almacena conexion.query 
qy = util.promisify(conexion.query).bind(conexion);


//INICIO tabla categoria//
//Método Get "/categoria"
app.get("/categoria", async (req, res) => {
    try {

        let query = "SELECT * FROM categoria";
        let response = await qy(query);
        res.status(200).send({ "Respuesta": response });
    }
    catch (e) {
        console.error(e.message);
        res.status(413).send({ "Error": e.message });
    }
});

//Método get "/categoria/:id" para listar una sola categoria
app.get("/categoria/:id", async (req, res) => {
    try {

        let query = "SELECT * FROM categoria WHERE id= ?";
        let response = await qy(query, [req.params.id]);
        if (response.length == 0) {
            throw new Error("Categoría no encontrada")
        }
        res.status(200).send({ "Respuesta": response });
    }
    catch (e) {
        console.error(e.message);
        res.status(413).send({ "Error": e.message });
    }
});

//Método Post "/categoria" 
app.post("/categoria", async (req, res) => {
    try {

        let nombre = req.body.nombre.toUpperCase();

        // Valido que me manden correctamente la información requerida (nombre)
        if (!nombre) {
            throw new Error("Falta enviar el nombre");
        }

        // Verifico que no exista previamente esa categoria
        let query = "SELECT id FROM categoria WHERE nombre = ?";
        let response = await qy(query, [nombre]);
        if (response.length > 0) {
            throw new Error("Esa categoria ya existe");
        }

        // Guardo la nueva categoria
        query = "INSERT INTO categoria (nombre) VALUE (?)";
        response = await qy(query, [nombre]);
        console.log(response + "Se agregó la categoría de nombre:", nombre);
        res.status(200).send({ "Se agregó la categoría con el siguiente número de id": response.insertId, "Nombre": nombre});
    }
    catch (e) {
        console.error(e.message);
        res.status(413).send({ "Error": e.message });
    }
});

//Método Delete "/categoria/:id"
app.delete("/categoria/:id", async (req, res) => {
    try {

        let query = "SELECT * FROM libro WHERE categoria_id = ? ";
        let response = await qy(query, [req.params.id]);
        if (response.length > 0) {
            throw new Error("Esta categoria tiene libros asociados, no se puede borrar");
        }
        
         query = "SELECT * FROM categoria WHERE id = ? ";
         response = await qy(query, [req.params.id]);
        if (response.length === 0){
            throw new Error("No se puede borrar porque la categoría indicada NO existe");
        }
        query = "DELETE FROM categoria WHERE id =?";
        response = await qy(query, [req.params.id]);
        console.log(response + "Se eliminó la categoría");
        res.status(200).send({ "Se eliminó correctamente la siguiente cantidad de categorías ": response.affectedRows });
    }
    catch (e) {
        console.error(e.message); 
        res.status(413).send({ "No se pudo eliminar": e.message }); 
    }
});
//FIN tabla categoria//


//INICIO tabla persona//
//Método Get "/persona"
app.get("/persona", async (req, res) => {
    try {

        let query = "SELECT * FROM persona";
        let response = await qy(query);
        res.status(200).send({ "Estos son los datos de las personas cargadas ": response });
    }
    catch (e) {
        console.error(e.message);
        res.status(413).send({ "Error": e.message });
    }
});

//Método Get "/persona:id"
app.get("/persona/:id", async (req, res) => {
    try {

        let query = "SELECT * FROM persona WHERE id = ?";
        let response = await qy(query, [req.params.id]);
        if (response.length == 0) {
            throw new Error("Persona no encontrada")
        }
        res.status(200).send({ "Respuesta": response });
    }
    catch (e) {
        console.error(e.message); 
        res.status(413).send({ "Error": e.message }); 

    }
});

//Método Post "/persona"
app.post("/persona", async (req, res) => {

    let nombre = req.body.nombre.toUpperCase();
    let apellido = req.body.apellido.toUpperCase();
    let alias = req.body.alias.toUpperCase();
    let email = req.body.email;

    try {

        if (!nombre || !apellido || !alias || !email) {
            throw new Error("Asegúrse de haber enviado: NOMBRE, APELLIDO, ALIAS, EMAIL");
        }
        let query = "SELECT * FROM persona WHERE email = ?";
        let response = await qy(query, [email]);

        //Pregunto si ya había un mail registrado que se duplicaría
        if (response.length > 0) {
            throw new Error("Persona con email ya registrado, ingrese nuevos datos");
        }
        query = "INSERT INTO persona (nombre, apellido, email, alias) VALUES (?, ?, ?, ?)";
        response = await qy(query, [nombre, apellido, email, alias]);

        console.log(response + "persona ingresada correctamente");
        res.status(200).send({ "Persona ingresada": nombre, apellido, email, alias, " Con la ID": response.insertId });
    }
    catch (e) {
        console.error(e.message);
        res.status(413).send({ "Error": e.message });
    }
});


//Método Put "/persona/:id"
app.put("/persona/:id", async (req, res) => {

    let nombre = req.body.nombre.toUpperCase();
    let apellido = req.body.apellido.toUpperCase();    
    let alias = req.body.alias.toUpperCase();
    let email = req.body.email;

 //Se pueden actualizar todos los datos salvo el email de registro.
    try {
        
        if (!nombre || !apellido || !alias) {
            throw new Error("Faltan algunos datos para realizar el update");
        }
        let query = "SELECT * FROM persona WHERE id = ? ";
        let response = await qy(query, [req.params.id]);
        if (response.length == 0) {
            throw new Error("No se encuentra esa persona.");
        }

      //Tiro error si ya había un mail registrado: no se puede cambiar
        if (email) {
             throw new Error("El mail y el ID no se puede modificar, ingrese sólo NOMBRE, APELLIDO Y ALIAS");
        }

        query = "UPDATE persona SET nombre= ?, apellido = ?, alias=? WHERE id =?";
        response = await qy(query, [nombre, apellido, alias, req.params.id]);
        res.status(200).send({ "Actualizado con éxito. Nombre": nombre, " Apellido": apellido, " Alias": alias, response });
        console.log(response + "persona actualizada correctamente");

    }
    catch (e) {
        console.error(e.message);
        res.status(413).send({ "Error inesperado": e.message });
    }
});


//Método Delete "/persona/:id"
app.delete("/persona/:id", async (req, res) => {
    
    try {
        let query = "SELECT * FROM libro WHERE persona_id = ? ";
        let response = await qy(query, [req.params.id]);
        if (response.length > 0) {
            throw new Error("Esta persona tiene libros prestados no se puede borrar");
        }
       

        query = "SELECT * FROM persona WHERE id = ? ";
        response = await qy(query, [req.params.id]);
       if (response.length === 0){
           throw new Error("No se puede borrar porque esta PERSONA NO está registrada");
       }

        query = "DELETE FROM persona WHERE id =?";
        response = await qy(query, [req.params.id]);

       
        console.log(response + "Esta es la respuesta al delete");
        res.status(200).send({ "Persona eliminada con éxito": response.affectedRows });
    }
    catch (e) {
        console.error(e.message);
        res.status(413).send({ "Error": e.message });
    }
});

//FIN tabla persona//

//INICIO tabla libro//
//Método Get "/libro"
app.get("/libro", async (req, res) => {
    try {

        let query = "SELECT * FROM libro";
        let response = await qy(query);
        res.status(200).send({ "Respuesta": response });
    }
    catch (e) {
        console.error(e.message);
        res.status(413).send({ "Error": e.message });
    }
});

//Método Get "/libro/:id"
app.get("/libro/:id", async (req, res) => {

    try {

        let query = "SELECT * FROM libro WHERE id= ?";
        let response = await qy(query, [req.params.id]);
        if (response.length == 0) {
            throw new Error("Libro no encontrado")
        }
        res.status(200).send({ "Respuesta": response });
    }
    catch (e) {
        console.error(e.message);
        res.status(413).send({ "Error": e.message });
    }
});


//Método post "/libro"
app.post("/libro", async (req, res) => {
//Consideramos que el campo de descripción debe ser obligatorio ya que en el se informa el autor/a del libro y una breve sinopsis.
    let nombre = req.body.nombre.toUpperCase();
    let descripcion = req.body.descripcion.toUpperCase();
    let categorid = req.body.categoria_id;
    let persona = req.body.persona_id;
    

    try {

        if (!nombre || !descripcion || !categorid) {
            throw new Error("Hay algún dato que no fue enviado");
        }
        let query = "SELECT * FROM categoria WHERE id = ?";
        let response = await qy(query, [categorid]);

        if (response.length == 0) {
            throw new Error("Esa categoria no existe");
        }
        //Se puede agregar libros de igual nombre pero en distintas categoria: Ejemplo: El alquimista, Ben Jonson (1983) El alquimista, Paulo Coelho (2007)
        query = "SELECT * FROM libro WHERE nombre = ? AND categoria_id = ?";
        response = await qy(query, [nombre, categorid]);
        if (response.length >= 1) {
            throw new Error("El nombre del libro ya existe en esa categoria");
        }
        query = "INSERT INTO libro (nombre, descripcion, categoria_id, persona_id) VALUES (?, ?, ?, ?)";
        response = await qy(query, [nombre, descripcion, categorid, null]);

        console.log(response + "libro ingresado correctamente");
        res.status(200).send({ "Libro ingresado correctamente": nombre, categorid, persona, descripcion, "con id": response.insertId });
    }
    catch (e) {
        console.error(e.message);
        res.status(413).send({ "Error inesperado": e.message });
    }
});

//Método delete "/libro/:id"
app.delete("/libro/:id", async (req, res) => {
    try {

        let query = "SELECT persona_id FROM libro WHERE id= ? ";
        let response = await qy(query, [req.params.id]);
        if (response.length == 0) {
            throw new Error("Ese libro no existe");
        }
        if (response[0].persona_id !== null) {
            throw new Error("Ese libro está prestado");
        }
        if (response[0].persona_id == null) {
            query = "DELETE FROM libro WHERE id = ? ";
            response = await qy(query, [req.params.id]);
        }
        console.log(response + "esta es la respuesta al delete correcto");
        res.status(200).send({ "Se borró correctamente": response.affectedRows });
    }    
        catch (e) {
            console.error(e.message); 
            res.status(413).send({ "Error": e.message }); 
        }
    });
    


//Método Put "/libro/:id"
app.put("/libro/:id", async (req, res) => {

    let nombre = req.body.nombre.toUpperCase();
    let descripcion = req.body.descripcion.toUpperCase();
    let categorid = req.body.categoria_id;
    let personaid = req.body.persona_id;

    try {
//Se tomó la desición de que el usuario pueda modificar todos los datos ingresados del libro, ya que si se cargara con un error este podría ser enmendado. Por este motivo, la descripción no es el único campo modificable.
        if (!nombre || !descripcion || !categorid) {
            throw new Error("No se enviaron los datos necesarios para actualizar la información del libro");
        }

        /* para responder a la consigna, si se quisiera que no se cambie el nombre:
        let query = "SELECT * FROM libro WHERE nombre = ?";
        let response = await qy(query, [nombre, req.params.id]);
        if (response.length > 0){
            throw new Error("Este nombre de libro ya existe.");
        }
        */

        query = "SELECT * FROM categoria WHERE id = ?";
        response = await qy(query, [categorid]);

        if (response.length == 0) {
            throw new Error("No existe la categoria");
        }
        query = "UPDATE libro SET nombre = ?, descripcion = ?, categoria_id = ?, persona_id = ? WHERE id = ?";
        response = await qy(query, [nombre, descripcion, categorid, null, req.params.id]);

        res.status(200).send({
            "Modificación realizada en los siguientes campos": nombre, descripcion, categorid, personaid, "actualizado": response});
            console.log("Libro modificado");
    } 
    catch (e) {
        console.error(e.message); 
        res.status(413).send({ 
            "Error": e.message}); 
    }

});

//Método Put "/libro/prestar/:id"

app.put("/libro/prestar/:id", async (req, res) => {
    let usuario = req.body.persona_id;
    try {
        if (!usuario) {
            throw new Error("Usted debe enviar `persona_id = x (número de id)` para  prestar del libro");
        }
        let query = "SELECT * FROM persona WHERE id = ? ";
        let response = await qy(query, [usuario]);
        if (response.length == 0) {
            throw new Error("No se puede PRESTAR este libro porque esta ID de usuario NO está registrada");
        }
        query = "SELECT persona_id FROM libro WHERE id= ? ";
        response = await qy(query, [req.params.id]);
        if (response.length === 0) {
            throw new Error("Ese libro no existe");
        }
        if (response[0].persona_id !== null) {
            throw new Error("Ese libro está prestado");
        }
        if (response[0].persona_id == null) {
            query = "UPDATE libro SET  persona_id = ? WHERE id = ?";
            response = await qy(query, [usuario, req.params.id]);
        }
        console.log(response + "esta es la respuesta al delete correcto");
        res.status(200).send({ "Modificación concretada, prestado al usuario con ID": usuario, response });

    }
    catch (e) {
        console.error(e.message);
        res.status(413).send({ "Error": e.message });
    }
});


//Método Put "/libro/devolver/:id"
app.put("/libro/devolver/:id", async (req, res) => {

    try {

        let query = "SELECT persona_id FROM libro WHERE id= ? ";
        let response = await qy(query, [req.params.id]);

        if (response.length === 0) {
            throw new Error("Ese libro no existe");
        }
        if (response[0].persona_id === null) {
            throw new Error("Ese libro no está prestado");
        }
        if (response[0].persona_id !== null) {
            query = "UPDATE libro SET  persona_id = ? WHERE id = ?";
            response = await qy(query, [req.body.persona_id, req.params.id]);
        }

        res.status(200).send({ "Modificación concretada, libro devuelto": response });
    }
    catch (e) {
        console.error(e.message);
        res.status(413).send({ "Error": e.message });
    }
});
//FIN tabla libro//

//SERVER 
app.listen(port, () => {
    console.log("servidor listening on port: 3002, o", port);
});
