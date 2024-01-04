export default interface PreferencesListener {
  onDataChanged: (key: string) => void
}