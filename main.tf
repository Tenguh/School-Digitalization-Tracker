module "lambda" {
    source = "./Lambda"
    memory_size = var.memory_size
    function_name = var.function_name
    runtime = var.runtime
    timeout= var.timeout
  
}