# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ContributionType.create([
  { desc: 'IVA' },
  { desc: 'IMU' },
  { desc: "IRAP" },
  { desc: 'imposte sui redditi e ritenute alla fonte' },
  { desc: "imposte sostitutive delle imposte sui redditi e dell'Iva" },
  { desc: "IRPEF" },
  { desc: "INPS" },
  { desc: "INAIL" },
  { desc: "ENPALS" },
  { desc: "INPDAI" },
  { desc: "INPDAP" },
  { desc: "TASI" },
  { desc: "diritti camerali" },
  { desc: "interessi nei pagamenti a rate" },
  { desc: "ritenute d'acconto" },
  { desc: "tassa sui rifiuti" },
  { desc: "canone televisivo" },
  { desc: "liquidazione e controllo formale della dichiarazione" },
  { desc: "avviso di accertamento" },
  { desc: "avviso di irrogazione sanzioni" },
  { desc: "accertamento con adesione" },
  { desc: "conciliazione giudiziale" },
  { desc: "ravvedimento" },
  { desc: "f24 accise" },
])

VehicleType.create([
  { desc: 'autocarro'},
  { desc: 'furgone'},
  { desc: 'furgone'},
  { desc: 'trattore stradale'},
  { desc: 'rimorchio'},
  { desc: 'semirimorchio'}
])

# User.create(
#   {
#     uid: 'octavianrotari@example.com', 
#     email: 'octavianrotari@example.com', 
#     password: 'password', 
#     password_confirmation: 'password'
#   }
# )
