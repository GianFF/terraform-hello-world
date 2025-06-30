# Target que define la capacidad escalable del servicio ECS
resource "aws_appautoscaling_target" "ecs" {
  max_capacity       = var.max_capacity                # Máximo número de tareas ECS
  min_capacity       = var.min_capacity                # Mínimo número de tareas ECS
  resource_id        = var.resource_id                 # Formato: service/cluster-name/service-name
  scalable_dimension = "ecs:service:DesiredCount"      # Especificamos que queremos escalar la cantidad deseada de tareas
  service_namespace  = var.service_namespace           # Namespace 'ecs' para que sepa que es un servicio ECS
}

# Política de escalado automático (scale-out) basada en CPU promedio
resource "aws_appautoscaling_policy" "scale_out" {
  name               = "scale-out-policy"
  policy_type        = "TargetTrackingScaling"         # Usa un target value que intenta mantenerse constante
  resource_id        = var.resource_id
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = var.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.scale_out_threshold             # Escala si CPU promedio supera este valor (por ej. 50%)

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    scale_out_cooldown = 60                             # Tiempo de espera (en segundos) después de escalar para volver a escalar
    scale_in_cooldown  = 60                             # También lo respeta para desescalar
  }
}

# Política de desescalado (scale-in) basada en CPU, con ajustes por pasos
resource "aws_appautoscaling_policy" "scale_in" {
  name               = "scale-in-policy"
  policy_type        = "StepScaling"                   # Usa ajustes por umbral (step scaling)
  resource_id        = var.resource_id
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = var.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"       # Cambia la cantidad directamente (suma o resta tareas)
    cooldown                = 60                       # Tiempo de espera después de una acción
    metric_aggregation_type = "Average"                # Considera promedio de la métrica

    step_adjustment {
      metric_interval_upper_bound = 0                  # Si el valor está por debajo del target (ej: debajo de 30%)
      scaling_adjustment          = -1                 # Reduce en 1 la cantidad de tareas
    }
  }
}
