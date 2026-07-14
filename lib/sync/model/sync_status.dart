enum SyncStatus {
  idle,
  connecting,
  exporting,
  compressing,
  sending,
  waitingAck,
  importing,
  completed,
  failed,
  waitingPermission
}