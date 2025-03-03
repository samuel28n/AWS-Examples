# Importa as bibliotecas necessárias
require 'aws-sdk-s3'  # Biblioteca AWS SDK para interagir com o Amazon S3
require 'pry'         # Biblioteca para depuração interativa
require 'securerandom' # Biblioteca para gerar UUIDs aleatórios



# Define o nome do bucket a partir da variável de ambiente
bucket_name = ENV['BUCKET_NAME']

# Define a região do bucket
region = 'us-east-1' # Corrigido: estava sem aspas, o que causaria erro

# Cria um cliente AWS S3
cliente = Aws::S3::Client.new( # Corrigido: `aws::s3::Client` -> `Aws::S3::Client`
  region: region
)

# Gera um número aleatório de arquivos entre 1 e 6
number_of_files = 1 + rand(6)
puts "number_of_files: #{number_of_files}"

# Loop para criar e enviar arquivos ao S3
number_of_files.times do |i| # Corrigido: `.each` não era necessário
  puts "i: #{i}" # Corrigido: removido espaço extra dentro da interpolação

  filename = "file_#{i}.txt" # Nome do arquivo
  output_path = "/tmp/#{filename}" # Caminho temporário do arquivo

  # Cria e escreve um UUID aleatório no arquivo
  File.open(output_path, 'w') do |f| # Corrigido: `file.open` -> `File.open`
    f.write(SecureRandom.uuid) # Corrigido: `secureRandom.uuid` -> `SecureRandom.uuid`
  end

  # Faz o upload do arquivo para o bucket S3
  File.open(output_path, 'rb') do |f|
    cliente.put_object( # Corrigido: `s3.put_object` -> `cliente.put_object`
      bucket: bucket_name, # Corrigido: 'bucket-name' -> `bucket_name`
      key: filename, # Corrigido: 'filename' -> `filename`
      body: f
    )
  end
end
