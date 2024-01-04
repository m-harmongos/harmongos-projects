export class GlobalContext {
  private static instance: GlobalContext;
  private _objects = new Map<string, Object>();

  constructor() {}

  public static getContext() {
    if (!this.instance) {
      this.instance = new GlobalContext();
    }
    return this.instance;
  }

  getObject(key: string): Object | undefined {
    return this._objects.get(key);
  }

  setObject(key: string, objectClass: Object): void {
    this._objects.set(key, objectClass);
  }
}