import { useEffect, useState } from 'react';
import axios from 'axios';
import { UserCog, Search, AlertTriangle, CheckCircle, XCircle, Filter, Plus, Edit, Trash2, X, Save, ChevronRight, Shield, Mail, User } from 'lucide-react';
import { useAuth } from '../context/AuthContext';

/**
 * Interfaz que representa un usuario del sistema
 */
interface Usuario {
    id: number;
    email: string;
    nombre: string;
    rol: string;
    activo: boolean;
    password?: string; // Opcional para creación/edición
}

/**
 * Decodifica el token JWT para obtener el email del usuario autenticado
 */
const decodificarToken = (token: string | null): string | null => {
    if (!token) return null;
    try {
        const base64Url = token.split('.')[1];
        const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
        const jsonPayload = decodeURIComponent(
            atob(base64).split('').map((c) => '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2)).join('')
        );
        return JSON.parse(jsonPayload).sub || null;
    } catch (error) {
        console.error('Error al decodificar token:', error);
        return null;
    }
};

const TablaUsuarios = () => {
    const { token } = useAuth();

    // Estados principales
    const [usuarios, setUsuarios] = useState<Usuario[]>([]);
    const [usuariosFiltrados, setUsuariosFiltrados] = useState<Usuario[]>([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);
    
    // Estados de filtros
    const [busqueda, setBusqueda] = useState('');
    const [filtroRol, setFiltroRol] = useState<string>('TODOS');

    // Estados del Panel Lateral (Drawer)
    const [isDrawerOpen, setIsDrawerOpen] = useState(false);
    const [modalMode, setModalMode] = useState<'create' | 'edit'>('create');
    const [currentUser, setCurrentUser] = useState<Partial<Usuario>>({});
    const [modalError, setModalError] = useState<string | null>(null);

    const emailActual = decodificarToken(token) || localStorage.getItem('userEmail');

    useEffect(() => {
        cargarUsuarios();
    }, [token]);

    useEffect(() => {
        aplicarFiltros();
    }, [busqueda, filtroRol, usuarios]);

    const cargarUsuarios = async () => {
        setLoading(true);
        setError(null);
        try {
            const response = await axios.get('/api/usuarios', {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            const usuariosFormateados = response.data.map((u: any) => ({
                ...u,
                activo: Boolean(u.activo)
            }));
            setUsuarios(usuariosFormateados);
        } catch (err: any) {
            console.error('Error cargando usuarios:', err);
            setError(err.response?.data?.message || 'No se pudieron cargar los usuarios');
        } finally {
            setLoading(false);
        }
    };

    const aplicarFiltros = () => {
        let resultado = [...usuarios];
        if (filtroRol !== 'TODOS') {
            resultado = resultado.filter(u => u.rol === filtroRol);
        }
        if (busqueda.trim() !== '') {
            const termino = busqueda.toLowerCase();
            resultado = resultado.filter(u =>
                u.email.toLowerCase().includes(termino) ||
                u.nombre.toLowerCase().includes(termino)
            );
        }
        setUsuariosFiltrados(resultado);
    };

    // --- Manejo del Drawer ---
    const abrirDrawerCrear = () => {
        setModalMode('create');
        setCurrentUser({ activo: true, rol: 'CLIENTE' });
        setModalError(null);
        setIsDrawerOpen(true);
    };

    const abrirDrawerEditar = (usuario: Usuario) => {
        setModalMode('edit');
        setCurrentUser({ ...usuario, password: '' });
        setModalError(null);
        setIsDrawerOpen(true);
    };

    const cerrarDrawer = () => {
        setIsDrawerOpen(false);
        setCurrentUser({});
    };

    // --- Operaciones CRUD ---
    const guardarUsuario = async (e: React.FormEvent) => {
        e.preventDefault();
        setModalError(null);

        try {
            if (modalMode === 'create') {
                await axios.post('/api/usuarios', currentUser, {
                    headers: { 'Authorization': `Bearer ${token}` }
                });
                alert('✅ Usuario creado exitosamente');
            } else {
                await axios.put(`/api/usuarios/${currentUser.id}`, currentUser, {
                    headers: { 'Authorization': `Bearer ${token}` }
                });
                alert('✅ Usuario actualizado exitosamente');
            }
            cerrarDrawer();
            cargarUsuarios();
        } catch (err: any) {
            console.error('Error al guardar:', err);
            setModalError(err.response?.data?.message || 'Error al guardar usuario');
        }
    };

    const eliminarUsuario = async (id: number) => {
        if (!window.confirm('¿Estás seguro de que deseas eliminar este usuario? Esta acción no se puede deshacer.')) return;

        try {
            await axios.delete(`/api/usuarios/${id}`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            alert('🗑️ Usuario eliminado correctamente');
            cargarUsuarios();
        } catch (err: any) {
            console.error('Error al eliminar:', err);
            alert(err.response?.data?.message || 'Error al eliminar usuario');
        }
    };

    const cambiarEstadoUsuario = async (usuario: Usuario) => {
        try {
            await axios.put(`/api/usuarios/${usuario.id}`, {
                ...usuario,
                activo: !usuario.activo
            }, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            setUsuarios(usuarios.map(u => u.id === usuario.id ? { ...u, activo: !u.activo } : u));
        } catch (err: any) {
            console.error('Error al cambiar estado:', err);
            alert('Error al cambiar estado del usuario');
            cargarUsuarios();
        }
    };

    const obtenerEstiloRol = (rol: string) => {
        switch (rol) {
            case 'ADMIN': return 'bg-purple-100 text-purple-700 ring-purple-600/20';
            case 'VETERINARIO': return 'bg-blue-100 text-blue-700 ring-blue-600/20';
            case 'RECEPCIONISTA': return 'bg-orange-100 text-orange-700 ring-orange-600/20';
            default: return 'bg-gray-100 text-gray-700 ring-gray-500/10';
        }
    };

    return (
        <div className="min-h-screen bg-gray-50/50 p-6 font-sans">
            {/* Header Section */}
            <div className="max-w-7xl mx-auto mb-8">
                <div className="flex flex-col md:flex-row md:items-center justify-between gap-6 bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
                    <div>
                        <h1 className="text-3xl font-bold text-gray-900 flex items-center tracking-tight">
                            <div className="p-2 bg-indigo-50 rounded-lg mr-3">
                                <UserCog className="w-8 h-8 text-indigo-600" />
                            </div>
                            Gestión de Usuarios
                        </h1>
                        <p className="mt-2 text-gray-500 font-medium ml-14">Administra el acceso y roles del personal de la clínica</p>
                    </div>
                    
                    <button
                        onClick={abrirDrawerCrear}
                        className="group relative inline-flex items-center justify-center px-8 py-3.5 text-base font-bold text-white transition-all duration-200 bg-gradient-to-r from-indigo-600 to-violet-600 rounded-full hover:from-indigo-700 hover:to-violet-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-600 shadow-lg hover:shadow-indigo-500/30 transform hover:-translate-y-0.5"
                    >
                        <Plus className="w-5 h-5 mr-2 group-hover:rotate-90 transition-transform duration-300" />
                        Nuevo Usuario
                    </button>
                </div>
            </div>

            {/* Main Content */}
            <div className="max-w-7xl mx-auto">
                {/* Filters Bar */}
                <div className="bg-white rounded-xl shadow-sm border border-gray-100 p-4 mb-6 flex flex-col md:flex-row gap-4 items-center justify-between">
                    <div className="relative w-full md:w-96">
                        <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <Search className="h-5 w-5 text-gray-400" />
                        </div>
                        <input
                            type="text"
                            className="block w-full pl-10 pr-3 py-2.5 border border-gray-200 rounded-lg leading-5 bg-gray-50 placeholder-gray-400 focus:outline-none focus:bg-white focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm transition duration-150 ease-in-out"
                            placeholder="Buscar por nombre o email..."
                            value={busqueda}
                            onChange={(e) => setBusqueda(e.target.value)}
                        />
                    </div>
                    
                    <div className="flex items-center gap-4 w-full md:w-auto">
                        <div className="relative w-full md:w-64">
                            <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <Filter className="h-5 w-5 text-gray-400" />
                            </div>
                            <select
                                value={filtroRol}
                                onChange={(e) => setFiltroRol(e.target.value)}
                                className="block w-full pl-10 pr-10 py-2.5 text-base border border-gray-200 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-lg bg-gray-50"
                            >
                                <option value="TODOS">Todos los roles</option>
                                <option value="ADMIN">Administrador</option>
                                <option value="VETERINARIO">Veterinario</option>
                                <option value="RECEPCIONISTA">Recepcionista</option>
                                <option value="CLIENTE">Cliente</option>
                            </select>
                        </div>
                        <div className="text-sm text-gray-500 font-medium whitespace-nowrap bg-gray-100 px-3 py-2 rounded-lg">
                            {usuariosFiltrados.length} Usuarios
                        </div>
                    </div>
                </div>

                {/* Elegant Table */}
                <div className="bg-white rounded-2xl shadow-xl overflow-hidden border border-gray-100">
                    {loading ? (
                        <div className="p-20 text-center">
                            <div className="inline-block animate-spin rounded-full h-10 w-10 border-4 border-indigo-100 border-t-indigo-600"></div>
                            <p className="mt-4 text-gray-500 font-medium">Cargando usuarios...</p>
                        </div>
                    ) : error ? (
                        <div className="p-10 text-center">
                            <div className="inline-flex items-center justify-center w-16 h-16 rounded-full bg-red-100 mb-4">
                                <AlertTriangle className="w-8 h-8 text-red-600" />
                            </div>
                            <h3 className="text-lg font-medium text-gray-900">Error al cargar datos</h3>
                            <p className="mt-2 text-gray-500">{error}</p>
                        </div>
                    ) : (
                        <div className="overflow-x-auto">
                            <table className="min-w-full divide-y divide-gray-200">
                                <thead>
                                    <tr className="bg-gray-50/50">
                                        <th scope="col" className="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">Usuario</th>
                                        <th scope="col" className="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">Rol</th>
                                        <th scope="col" className="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">Estado</th>
                                        <th scope="col" className="px-6 py-4 text-right text-xs font-bold text-gray-500 uppercase tracking-wider">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody className="bg-white divide-y divide-gray-200">
                                    {usuariosFiltrados.map((usuario) => (
                                        <tr key={usuario.id} className="hover:bg-indigo-50/30 transition-colors duration-150 group">
                                            <td className="px-6 py-4 whitespace-nowrap">
                                                <div className="flex items-center">
                                                    <div className="flex-shrink-0 h-12 w-12">
                                                        <div className="h-12 w-12 rounded-full bg-gradient-to-br from-indigo-500 to-purple-600 flex items-center justify-center text-white font-bold text-xl shadow-md">
                                                            {usuario.nombre.charAt(0).toUpperCase()}
                                                        </div>
                                                    </div>
                                                    <div className="ml-4">
                                                        <div className="text-sm font-bold text-gray-900">{usuario.nombre}</div>
                                                        <div className="text-sm text-gray-500 flex items-center mt-0.5">
                                                            <Mail className="w-3 h-3 mr-1" />
                                                            {usuario.email}
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td className="px-6 py-4 whitespace-nowrap">
                                                <span className={`inline-flex items-center px-3 py-1 rounded-full text-xs font-medium ring-1 ring-inset ${obtenerEstiloRol(usuario.rol)}`}>
                                                    {usuario.rol}
                                                </span>
                                            </td>
                                            <td className="px-6 py-4 whitespace-nowrap">
                                                <button 
                                                    onClick={() => cambiarEstadoUsuario(usuario)}
                                                    className={`inline-flex items-center px-3 py-1 rounded-full text-xs font-medium transition-colors cursor-pointer ${
                                                        usuario.activo 
                                                        ? 'bg-green-50 text-green-700 ring-1 ring-inset ring-green-600/20 hover:bg-green-100' 
                                                        : 'bg-red-50 text-red-700 ring-1 ring-inset ring-red-600/20 hover:bg-red-100'
                                                    }`}
                                                >
                                                    {usuario.activo ? <CheckCircle className="w-3 h-3 mr-1.5" /> : <XCircle className="w-3 h-3 mr-1.5" />}
                                                    {usuario.activo ? 'Activo' : 'Inactivo'}
                                                </button>
                                            </td>
                                            <td className="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                                <div className="flex items-center justify-end space-x-2 opacity-0 group-hover:opacity-100 transition-opacity duration-200">
                                                    <button 
                                                        onClick={() => abrirDrawerEditar(usuario)}
                                                        className="p-2 text-indigo-600 hover:bg-indigo-50 rounded-lg transition-colors"
                                                        title="Editar usuario"
                                                    >
                                                        <Edit className="w-5 h-5" />
                                                    </button>
                                                    <button 
                                                        onClick={() => eliminarUsuario(usuario.id)}
                                                        className="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors"
                                                        title="Eliminar usuario"
                                                        disabled={usuario.email === emailActual}
                                                    >
                                                        <Trash2 className="w-5 h-5" />
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    )}
                </div>
            </div>

            {/* Slide-over Panel (Drawer) */}
            <div className={`fixed inset-0 overflow-hidden z-50 ${isDrawerOpen ? '' : 'pointer-events-none'}`}>
                <div className="absolute inset-0 overflow-hidden">
                    {/* Backdrop */}
                    <div 
                        className={`absolute inset-0 bg-gray-900/50 backdrop-blur-sm transition-opacity duration-500 ${isDrawerOpen ? 'opacity-100' : 'opacity-0'}`} 
                        onClick={cerrarDrawer}
                    />

                    {/* Panel */}
                    <div className={`fixed inset-y-0 right-0 pl-10 max-w-full flex transform transition duration-500 sm:duration-700 ease-in-out ${isDrawerOpen ? 'translate-x-0' : 'translate-x-full'}`}>
                        <div className="w-screen max-w-md">
                            <div className="h-full flex flex-col bg-white shadow-2xl">
                                {/* Header del Drawer */}
                                <div className="px-4 py-6 bg-gradient-to-r from-indigo-600 to-violet-600 sm:px-6">
                                    <div className="flex items-center justify-between">
                                        <h2 className="text-xl font-bold text-white flex items-center">
                                            {modalMode === 'create' ? <Plus className="w-6 h-6 mr-2" /> : <Edit className="w-6 h-6 mr-2" />}
                                            {modalMode === 'create' ? 'Nuevo Usuario' : 'Editar Usuario'}
                                        </h2>
                                        <button onClick={cerrarDrawer} className="text-indigo-100 hover:text-white transition-colors rounded-full p-1 hover:bg-white/10">
                                            <X className="w-6 h-6" />
                                        </button>
                                    </div>
                                    <p className="mt-2 text-indigo-100 text-sm">
                                        {modalMode === 'create' 
                                            ? 'Complete la información para registrar un nuevo usuario en el sistema.' 
                                            : 'Modifique los datos del usuario seleccionado.'}
                                    </p>
                                </div>

                                {/* Formulario */}
                                <div className="relative flex-1 px-4 sm:px-6 py-6 overflow-y-auto bg-gray-50">
                                    <form onSubmit={guardarUsuario} className="space-y-6">
                                        {modalError && (
                                            <div className="bg-red-50 border border-red-200 text-red-700 p-4 rounded-xl text-sm flex items-start">
                                                <AlertTriangle className="w-5 h-5 mr-2 flex-shrink-0 mt-0.5" />
                                                {modalError}
                                            </div>
                                        )}

                                        <div className="bg-white p-5 rounded-xl shadow-sm border border-gray-100 space-y-4">
                                            <div>
                                                <label className="block text-sm font-semibold text-gray-700 mb-1.5">Nombre Completo</label>
                                                <div className="relative">
                                                    <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                        <User className="h-5 w-5 text-gray-400" />
                                                    </div>
                                                    <input
                                                        type="text"
                                                        required
                                                        value={currentUser.nombre || ''}
                                                        onChange={e => setCurrentUser({...currentUser, nombre: e.target.value})}
                                                        className="block w-full pl-10 pr-3 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition-colors"
                                                        placeholder="Ej: Juan Pérez"
                                                    />
                                                </div>
                                            </div>

                                            <div>
                                                <label className="block text-sm font-semibold text-gray-700 mb-1.5">Correo Electrónico</label>
                                                <div className="relative">
                                                    <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                        <Mail className="h-5 w-5 text-gray-400" />
                                                    </div>
                                                    <input
                                                        type="email"
                                                        required
                                                        value={currentUser.email || ''}
                                                        onChange={e => setCurrentUser({...currentUser, email: e.target.value})}
                                                        className="block w-full pl-10 pr-3 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition-colors"
                                                        placeholder="ejemplo@correo.com"
                                                    />
                                                </div>
                                            </div>

                                            {modalMode === 'create' && (
                                                <div>
                                                    <label className="block text-sm font-semibold text-gray-700 mb-1.5">Contraseña</label>
                                                    <div className="relative">
                                                        <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                            <Shield className="h-5 w-5 text-gray-400" />
                                                        </div>
                                                        <input
                                                            type="password"
                                                            required
                                                            value={currentUser.password || ''}
                                                            onChange={e => setCurrentUser({...currentUser, password: e.target.value})}
                                                            className="block w-full pl-10 pr-3 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition-colors"
                                                            placeholder="••••••••"
                                                        />
                                                    </div>
                                                </div>
                                            )}
                                        </div>

                                        <div className="bg-white p-5 rounded-xl shadow-sm border border-gray-100 space-y-4">
                                            <div>
                                                <label className="block text-sm font-semibold text-gray-700 mb-1.5">Rol del Usuario</label>
                                                <select
                                                    value={currentUser.rol || 'CLIENTE'}
                                                    onChange={e => setCurrentUser({...currentUser, rol: e.target.value})}
                                                    className="block w-full pl-3 pr-10 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition-colors"
                                                >
                                                    <option value="ADMIN">Administrador</option>
                                                    <option value="VETERINARIO">Veterinario</option>
                                                    <option value="RECEPCIONISTA">Recepcionista</option>
                                                    <option value="CLIENTE">Cliente</option>
                                                </select>
                                                <p className="mt-1.5 text-xs text-gray-500">
                                                    Define los permisos y accesos que tendrá este usuario en el sistema.
                                                </p>
                                            </div>

                                            <div className="flex items-center justify-between pt-2">
                                                <div className="flex flex-col">
                                                    <span className="text-sm font-semibold text-gray-700">Estado de la cuenta</span>
                                                    <span className="text-xs text-gray-500">Permitir acceso al sistema</span>
                                                </div>
                                                <button
                                                    type="button"
                                                    onClick={() => setCurrentUser({...currentUser, activo: !currentUser.activo})}
                                                    className={`relative inline-flex h-6 w-11 flex-shrink-0 cursor-pointer rounded-full border-2 border-transparent transition-colors duration-200 ease-in-out focus:outline-none focus:ring-2 focus:ring-indigo-600 focus:ring-offset-2 ${
                                                        currentUser.activo ? 'bg-green-500' : 'bg-gray-200'
                                                    }`}
                                                >
                                                    <span
                                                        className={`pointer-events-none inline-block h-5 w-5 transform rounded-full bg-white shadow ring-0 transition duration-200 ease-in-out ${
                                                            currentUser.activo ? 'translate-x-5' : 'translate-x-0'
                                                        }`}
                                                    />
                                                </button>
                                            </div>
                                        </div>

                                        <div className="pt-4 flex gap-3">
                                            <button
                                                type="button"
                                                onClick={cerrarDrawer}
                                                className="flex-1 px-4 py-3 text-gray-700 bg-white border border-gray-300 rounded-xl hover:bg-gray-50 font-medium transition-colors shadow-sm"
                                            >
                                                Cancelar
                                            </button>
                                            <button
                                                type="submit"
                                                className="flex-1 px-4 py-3 bg-indigo-600 text-white rounded-xl hover:bg-indigo-700 font-bold transition-colors shadow-lg shadow-indigo-200 flex items-center justify-center"
                                            >
                                                <Save className="w-5 h-5 mr-2" />
                                                Guardar Usuario
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default TablaUsuarios;
