# ifndef NMAP_LUA_H
# define NMAP_LUA_H
# include <vector>
# include <set>
# include <string>
# include "nse_lua.h"
# include "scan_lists.h"
➜ class ScriptResult
{
  private:
    std::string id;
    /* Structured output table, an integer ref in L_NSE[LUA_REGISTRYINDEX]. */
    int output_ref;
    /* Unstructured output string, for scripts that do not return a structured
       table, or return a string in addition to a table. */
    std::string output_str;
  public:
    ScriptResult() {
      output_ref = LUA_NOREF;
    }
    ~ScriptResult() {
      // ensures Lua ref is released
      clear();
    }
    void clear (void);
    void set_output_tab (lua_State *, int);
    void set_output_str (const char *);
    void set_output_str (const char *, size_t);
    std::string get_output_str (void) const;
    void set_id (const char *);
    const char *get_id (void) const;
    void write_xml() const;
    bool operator<(ScriptResult const &b) const {
      return this->id.compare(b.id) < 0;
    }
};
`
➜ typedef std::multiset<ScriptResult *> ScriptResults;
`
/* Call this to get a ScriptResults object which can be
 * used to store Pre-Scan and Post-Scan script Results */
➜ ScriptResults *get_script_scan_results_obj (void);
`
➜ class Target;
`
/* API */
>>> int nse_yield (lua_State *, lua_KContext, lua_KFunction);
>>> void nse_restore (lua_State *, int);
>>> void nse_destructor (lua_State *, char);
>>> void nse_base (lua_State *);
>>> void nse_selectedbyname (lua_State *);
>>> void nse_gettarget (lua_State *, int);
`
>>> void open_nse (void);
>>> void script_scan (std::vector<Target *> &targets, stype scantype);
>>> void close_nse (void);
`
# define SCRIPT_ENGINE "NSE"
# ifdef WIN32
# _define SCRIPT_ENGINE_LUA_DIR "scripts\\"
# _define SCRIPT_ENGINE_LIB_DIR "nselib\\"
# else
# _define SCRIPT_ENGINE_LUA_DIR "scripts/"
# _define SCRIPT_ENGINE_LIB_DIR "nselib/"
# endif
`
# define SCRIPT_ENGINE_DATABASE SCRIPT_ENGINE_LUA_DIR "script.db"
# define SCRIPT_ENGINE_EXTENSION ".nse"
`
# endif
"quit"
