# 開発用のサンプルデータ。何度実行しても同じ状態になる
Todo.delete_all
Category.delete_all
User.delete_all

today = Date.current
work, shopping, study = %w[仕事 買い物 勉強].map { |name| Category.create!(name:) }

alice = User.create!(name: "alice", email: "alice@example.com", password: "password")
bob = User.create!(name: "bob", email: "bob@example.com", password: "password")

[
  { title: "企画書を出す", category: work, due_on: today - 2 },
  { title: "週報を書く", category: work, due_on: today },
  { title: "牛乳を買う", category: shopping, due_on: today + 1 },
  { title: "Rails ガイドを読む", category: study, due_on: today + 7, memo: "1章: はじめに\n2章: ルーティング" },
  { title: "経費を精算する", category: work, due_on: today - 1, done: true },
  { title: "本を返す", category: nil, due_on: nil },
  { title: "資料に目を通す", category: work, due_on: today + 3, memo: "<b>厳守</b>：月曜の朝まで\n要点を3つにまとめる" },
  { title: "電球を買う", category: shopping, due_on: today + 2 },
  { title: "テストを書く", category: study, due_on: nil, done: true },
  { title: "会議の資料を作る", category: work, due_on: today + 5 },
].each { |attrs| alice.todos.create!(attrs) }

[
  { title: "bob の秘密のタスク", category: work, due_on: today + 1, memo: "alice には見えてはいけない" },
  { title: "bob の買い物", category: shopping, due_on: nil },
].each { |attrs| bob.todos.create!(attrs) }

puts "users: #{User.count}, categories: #{Category.count}, todos: #{Todo.count}"
