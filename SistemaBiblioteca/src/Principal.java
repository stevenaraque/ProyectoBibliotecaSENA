/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author USER
 */
public class Principal {

    public static void main(String[] args) {
        LibroDAO dao = new LibroDAO();

        // 1. ACTUALIZAR: Vamos a cambiar el título del libro con ID 21 que creamos antes
        Libro libroAActualizar = new Libro();
        libroAActualizar.setIdLibro(21);
        libroAActualizar.setTitulo("Java Avanzado SENA"); // Nuevo nombre
        libroAActualizar.setIsbn("123-456-789");
        libroAActualizar.setAnioPublicacion(2026);

        if (dao.actualizarLibro(libroAActualizar)) {
            System.out.println("¡Libro actualizado correctamente!");
        }

        // 2. ELIMINAR: Borramos el libro con ID 21
        if (dao.eliminarLibro(21)) {
            System.out.println("¡Libro eliminado correctamente!");
        }

        // 3. Verificamos que ya no esté
        System.out.println("\n--- Lista Final de Libros ---");
        for (Libro l : dao.listarLibros()) {
            System.out.println("ID: " + l.getIdLibro() + " | Título: " + l.getTitulo());
        }
    }
}
