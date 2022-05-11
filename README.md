# iQuiz
A Multiple-Choice Q-and-A application

users can choose from a collection of quizzes

each quiz has a number (1-to-many) of questions

each question is a multiple-choice answer

users progress through each question one at a time

app will track their answers

app could upload their scores

quizzes are updated from a server


Basic interaction

we need a list for all the quiz topics

each element will lead the user to a list of questions

start with the TableView filled with subjects

use Mathematics, Marvel Super Heroes, and Science

for now, use an in-memory array

make sure to build this as a UITableViewSource


TableView cells

icon on the left (any image works)

subject: title (30 characters)

description: short sentence

ToolBar across the top

put a button on the Toolbar, title it "Settings"

"Settings" should (for now) pop a UIAlertController

have it read "Settings go here"/"OK"


Grading: 5 points

repo should be called 'iQuiz'

TableView appears with nonempty cells: 1 pt

TableView has the right number of cells: 1 pt

TableCells have the right data: 1 pt

TableCells display icons and subtext: 1 pt

Settings alert: 1 pt
