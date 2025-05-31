<?php
session_start();
if (isset($_SESSION['usuario'])) {
    header('Location: dashboard.php');
    exit;
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Iniciar Sesión</title>
  <style>
    body { font-family: Arial; background: #f0f0f0; padding: 50px; }
    form { background: white; padding: 20px; max-width: 300px; margin: auto; border-radius: 8px; }
    input { width: 100%; margin: 10px 0; padding: 10px; }
    button { padding: 10px; width: 100%; background: #007bff; color: white; border: none; }
  </style>
</head>
<body>
  <form action="auth/validar.php" method="POST">
    <h2>Login</h2>
    <input type="text" name="usuario" placeholder="Usuario" required>
    <input type="password" name="clave" placeholder="Contraseña" required>
    <button type="submit">Ingresar</button>
  </form>
</body>
</html>
