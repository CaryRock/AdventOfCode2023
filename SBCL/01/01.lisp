;;;; Idea: read from left until first digit found, then read from right until
;;;; first digit (from the right) is found. Combine the two and sum over lines.

(defvar *sums* ())

(defun check-if-number-p (char)
  (cond
    ((null char) nil)
    ((not (digit-char-p char)) nil)
    (t t)))                         ; Assuming that if it filters here, it's a number
    ;(t (digit-char-p char))))      

(defun read-until-number (line)
  (loop for c across line
        do (if (check-if-number-p c) (return (digit-char-p c)))))

(defun main()
  ;(let ((in (open "test.data")))    ; Open the file with the data
  (let ((in (open "01.data")))
  (loop for line = (read-line in nil)
        while line do (progn
                        (setf *sums* (cons (* 10 (read-until-number line)) *sums*))
                        (setf (car *sums*) (+ (read-until-number (reverse line)) (car *sums*)))))
  (close in))                       ; Close the file
  (format t "Total: ~a~%" (reduce #'+ *sums*)))
  ;(format t "Calibration values:~%~{~a~%~}" (reverse *sums*))) ; Print to stdout the list of sums
