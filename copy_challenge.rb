require 'fileutils'

# Define paths
ENV_FILE = '.env'
CHALLENGES_DIR = './challenges'
COMMUNITY_DIR = './community'

# Read or prompt for CURRENT_USER
def get_or_set_current_user
  if File.exist?(ENV_FILE)
    env_content = File.read(ENV_FILE)
    if env_content.match(/^CURRENT_USER=(.+)/)
      return env_content.match(/^CURRENT_USER=(.+)/)[1]
    end
  end

  # Prompt user for input if CURRENT_USER is missing
  print "Digite seu nome de usuário: "
  user = gets.chomp
  File.open(ENV_FILE, 'a') { |file| file.puts "CURRENT_USER=#{user}" }
  puts "CURRENT_USER=#{user} foi salvo em #{ENV_FILE}."
  user
end

# List all challenges
def list_challenges
  challenges = {}
  categories = Dir.entries(CHALLENGES_DIR).select { |entry| File.directory?(File.join(CHALLENGES_DIR, entry)) && !['.', '..'].include?(entry) }

  categories.each do |category|
    challenges_in_category = Dir.entries(File.join(CHALLENGES_DIR, category)).select { |entry| File.directory?(File.join(CHALLENGES_DIR, category, entry)) && !['.', '..'].include?(entry) }
    challenges_in_category.each { |challenge| challenges[challenge] = File.join(category, challenge) }
  end

  challenges
end

# Main script logic
def main
  current_user = get_or_set_current_user

  # List challenges
  puts "Desafios disponíveis:"
  challenges = list_challenges
  challenges.each_key { |challenge| puts " - #{challenge}" }

  print "Digite o nome do desafio que deseja copiar: "
  challenge_name = gets.chomp

  # Validate challenge name
  if challenges[challenge_name].nil?
    puts "Erro: Nenhum desafio encontrado com o nome '#{challenge_name}'."
    return
  end

  # Copy challenge
  source_path = File.join(CHALLENGES_DIR, challenges[challenge_name])
  target_path = File.join(COMMUNITY_DIR, current_user, challenges[challenge_name])

  FileUtils.mkdir_p(target_path)
  FileUtils.cp_r(source_path, target_path)

  puts "O desafio '#{challenge_name}' foi copiado com sucesso para '#{target_path}'."
end

# Execute script
main