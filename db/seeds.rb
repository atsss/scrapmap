users_hash = [
  { name: 'Ats', email: 'test01@example.com', password: 'passpass'},
  { name: 'Yoshi', email: 'test02@example.com', password: 'passpass'}
]

users_hash.each { |attributes| Users::Create.run!(attributes) }
Communities::Create.run!(name: 'CIID', user_ids: User.all.ids)
