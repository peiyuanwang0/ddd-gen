
export interface IModuleNameRepository {
    findOne: (id: string) => Promise<any | null>;
}
