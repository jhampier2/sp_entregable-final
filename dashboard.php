<?php 
include 'includes/sesion.php';

if ($_SESSION['rol'] !== 'admin') {
    echo "<h2>Acceso no autorizado.</h2>";
    exit;
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <title>Panel de Control</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
  <style>
    body {
      background: url('img/inicio.jpg') no-repeat center center fixed;
      background-size: cover;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      align-items: center;
      padding: 2rem 1rem;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      color: #fff;
      position: relative;
    }
    h1 {
     color: #ffffff;
      text-shadow: 2px 2px 6px rgba(0, 219, 235, 0.5);
      margin-bottom: 0.5rem;
      font-size: 2.2rem;
   }

    .menu {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
      gap: 20px;
      width: 100%;
      max-width: 900px;
      margin-top: 2rem;
    }
    .item {
      background: #fff;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgb(0 0 0 / 0.1);
      text-align: center;
      padding: 1.5rem 1rem;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      cursor: pointer;
      user-select: none;
    }
    .item:hover {
      transform: translateY(-5px);
      box-shadow: 0 8px 20px rgb(0 0 0 / 0.15);
    }
    .item a {
      text-decoration: none;
      color: #0d6efd;
      font-weight: 600;
      font-size: 1.25rem;
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 0.5rem;
    }
    .item a .bi {
      font-size: 2.5rem;
      color: #0d6efd;
    }
    .logout-link {
      align-self: flex-end;
      margin-bottom: 1rem;
      font-weight: 500;
      color: #555;
      transition: color 0.2s;
    }
    .logout-link:hover {
      color: #dc3545;
      text-decoration: underline;
    }
  </style>
</head>
<body>

  <h1>Bienvenido, <?php echo htmlspecialchars($_SESSION['usuario']); ?></h1>
  <a href="logout.php" class="logout-link">Cerrar sesión</a>

  <div class="menu">
    <div class="item">
      <a href="clientes/">
        <i class="bi bi-people-fill"></i>
        Clientes
      </a>
    </div>
    <div class="item">
      <a href="categorias/">
        <i class="bi bi-tags-fill"></i>
        Categorías
      </a>
    </div>
    <div class="item">
      <a href="productos/index.html">
        <i class="bi bi-box-seam"></i>
        Productos
      </a>
    </div>
    <div class="item">
      <a href="proveedores/">
        <i class="bi bi-truck"></i>
        Proveedores
      </a>
    </div>
    <div class="item">
      <a href="ventas/">
        <i class="bi bi-cart-fill"></i>
        Ventas
      </a>
    </div>
  </div>
  <a href="ventas/reporte/reporte_ventas_completo.php">Reporte Ventas PDF</a>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
