;;;; Idea: read from left until first digit found, then read from right until
;;;; first digit (from the right) is found. Combine the two and sum over lines.

;; Step 1: Larnin' to friggin' read (a file)
(defun read-from-left (string count-list scale)
  "Iterates over string and conses the first digit seen (multiplied by scale) to count-list."
  (let ((*temp* ()))
  (loop for c across string while (digit-char-p c)
        do (cons (* scale (digit-char-p c)) *temp*))
  (format t "*temp*: ~{~a ~}~%" *temp*)
  (setf count-list (cons *temp* count-list))))

(defun read-from-right (string count-list scale)
  "Same as read-from-left, but reverses string beforehand."
  (read-from-left (reverse string) count-list scale))

(defun main()
  (let ((*tens* (list ()))
        (*ones* (list ()))
        (in (open "test.data"))
        (lines ()))
    (when in
      (loop for line = (read-line in nil)
            while line do (cons line lines))
      (close in))
    (loop for line in lines
          do (print line)
          do (read-from-left line *tens* 10)
          do (read-from-right line *ones* 1))
    (format t "Tens: ~{~a ~}~%" *tens*)
    (format t "Ones: ~{~a ~}~%" *ones*)))
