# -*- coding: utf-8 -*-

require_relative 'number'
require_relative 'add'
require_relative 'multiply'
require_relative 'machine'
require_relative 'boolean'
require_relative 'less_than'
require_relative 'variable'
require_relative 'do_nothing'
require_relative 'assign'
require_relative 'if'
require_relative 'sequence'
require_relative 'while'

# (+ (* 1 2) (* 3 4))
a = Add.new(
            Multiply.new(Number.new(1), Number.new(2)),
            Multiply.new(Number.new(3), Number.new(4)),
            )
# Machine.new(a).run

# (* 1 (* (+ 2 3) 4))
b = Multiply.new(
                 Number.new(1),
                 Multiply.new(
                              Add.new(Number.new(2),
                                      Number.new(3)),
                              Number.new(4)
                              )
                 )

# (< 5 (+ 2 2))
c = LessThan.new(Number.new(5), Add.new(Number.new(2), Number.new(2)))
# Machine.new(c).run

# (let ((x 3) (y 4)) (+ x y))
s0 = Add.new(Variable.new(:x), Variable.new(:y))
e0 = { x: Number.new(3), y: Number.new(4) }
# Machine.new(s0, e0).run


# (setq x (+ x 1))
s1 = Assign.new(:x, Add.new(Variable.new(:x), Number.new(1)))
e1 = { x: Number.new(2) }
# Machine.new(s1, e1).run

# (let ((x 1))
#   (if x (setq y 1) (setq y 2)))
s2 = If.new(
            Variable.new(:x),
            Assign.new(:y, Number.new(1)),
            Assign.new(:y, Number.new(2)))
e2 = { x: Boolean.new(true) }
# Machine.new(s2, e2).run

#'((setq x (+ 1 1) (setq y (+ x 3))))
s3 = Sequence.new(
                  Assign.new(:x, Add.new(Number.new(1), Number.new(1))),
                  Assign.new(:y, Add.new(Variable.new(:x), Number.new(3))))
e3 = {}
# Machine.new(s3, e3).run

# (let ((x 1))
#   (while (< x 5) (setq x (* x 3))))
s4 = While.new(
               LessThan.new(Variable.new(:x), Number.new(5)),
               Assign.new(:x, Multiply.new(Variable.new(:x), Number.new(3))))
e4 = { x: Number.new(1) }
# Machine.new(s4, e4).run

# (let ((x 2) (y 5)) (< (+ x 2) y))
s5 = LessThan.new(
                  Add.new(Variable.new(:x), Number.new(2)),
                  Variable.new(:y))
e5 = { x: Number.new(2), y: Number.new(5) }
# puts s5.evaluate(e5)

# puts s3.evaluate(e3)
# puts s4.evaluate(e4)


p0 = Number.new(5).to_ruby
puts eval(p0).call({})

p1 = Boolean.new(false).to_ruby
puts eval(p1).call({})

p2 = Variable.new(:x).to_ruby
puts eval(p2).call({ x: 7 })

p3 = Add.new(Variable.new(:x), Number.new(1)).to_ruby
puts p3


# 음.. lisp로 짜면 더 재미있을것 같다. ㅇㅇ.
# class : Number, Add, Multiply
# def: to_s, inspect
# def: reducible?
# def: reduce
# class: Machine - step, run
# class: Boolean, LessThan
# class: Variable
# environment 도입하면서, reduce 수정
# class: DoNothing - ==
# class: Assign
# class: If
# class: Sequence
# class: While
# def: evaluate
# def: to_ruby
