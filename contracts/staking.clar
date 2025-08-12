;; Basic Staking Platform (staking.clar)
;; Minimal staking contract with two public functions: stake and withdraw

(define-constant err-invalid-amount (err u100))
(define-constant err-insufficient-stake (err u101))

(define-map stakes principal uint)
(define-data-var total-staked uint u0)

(define-public (stake (amount uint))
  (begin
    (asserts! (> amount u0) err-invalid-amount)
    ;; transfer STX from caller to contract
    (try! (stx-transfer? amount tx-sender (as-contract tx-sender)))
    (map-set stakes tx-sender (+ (default-to u0 (map-get? stakes tx-sender)) amount))
    (var-set total-staked (+ (var-get total-staked) amount))
    (ok true)
  )
)

(define-public (withdraw (amount uint))
  (let ((current-stake (default-to u0 (map-get? stakes tx-sender))))
    (begin
      (asserts! (> amount u0) err-invalid-amount)
      (asserts! (>= current-stake amount) err-insufficient-stake)
      ;; transfer STX from contract back to caller
      (try! (stx-transfer? amount (as-contract tx-sender) tx-sender))
      (map-set stakes tx-sender (- current-stake amount))
      (var-set total-staked (- (var-get total-staked) amount))
      (ok true)
    )
  )
)

;; Read-only helpers (optional for frontends)
(define-read-only (get-stake (user principal))
  (ok (default-to u0 (map-get? stakes user))))

(define-read-only (get-total-staked)
  (ok (var-get total-staked))) 
