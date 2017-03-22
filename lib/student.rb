require 'pry'
class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  attr_reader :name, :id
  attr_accessor :grade

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end


  def self.create_table
    sql_create_table = <<-SQL
    CREATE TABLE IF NOT EXISTS students
    (id INTEGER PRIMARY KEY,
    name TEXT,
    grade INTEGER
    )
    SQL
    DB[:conn].execute(sql_create_table)
  end


  def self.drop_table
    sql_drop_table = <<-SQL
    DROP TABLE IF EXISTS students
    SQL
    DB[:conn].execute(sql_drop_table)
  end


  def save
    sql = <<-SQL
    INSERT INTO students (name, grade)
    VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
    last_id = 'SELECT LAST_INSERT_ROWID() FROM students'
    @id = DB[:conn].execute(last_id)[0][0]
    #binding.pry
  end


  def self.create(name:, grade:)
    student = self.new(name, grade)
    student.save
    student
    #binding.pry
  end


end
